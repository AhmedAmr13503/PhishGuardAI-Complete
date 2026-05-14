import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/errors/failures.dart';
import '../../../core/network/dio_client.dart';
import 'scan_model.dart';

class ScanApiService {
  ScanApiService(this._dioClient);

  final DioClient _dioClient;

  Future<ScanModel> scanUrl(String url) async {
    try {
      final response = await _dioClient.dio.post(
        ApiConstants.predictUrl,
        data: <String, dynamic>{'url': url},
      );

      final statusCode = response.statusCode ?? 0;
      if (statusCode >= 500) {
        throw const ServerFailure(
          'The scan service is temporarily unavailable. The backend may be offline.',
        );
      }
      if (statusCode == 404) {
        throw const ServerFailure(
          'The scan endpoint was not found (404). Check the server URL or VPN.',
        );
      }
      if (statusCode == 405) {
        throw const ServerFailure(
          'This request method is not allowed (405). The API may have changed.',
        );
      }
      if (statusCode >= 400) {
        throw ServerFailure(
          _messageForHttpBody(statusCode, response.data) ??
              'The server could not process this scan ($statusCode).',
        );
      }

      final raw = response.data;
      if (raw == null) {
        throw const UnknownFailure(
          'We received an empty response. Please try again.',
        );
      }
      if (raw is String) {
        throw UnknownFailure(_messageForUnexpectedBody(raw));
      }
      if (raw is! Map) {
        throw UnknownFailure(_messageForUnexpectedBody(raw.toString()));
      }

      final normalized = _normalizePredictResponse(
        Map<String, dynamic>.from(raw),
      );
      return ScanModel.fromJson(normalized);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } on Failure {
      rethrow;
    } on FormatException {
      throw const UnknownFailure(
        'We could not read the scan result. Please try again.',
      );
    } catch (e) {
      throw UnknownFailure(_sanitizeUnexpectedError(e));
    }
  }

  Future<List<ScanModel>> getScanHistory() async {
    try {
      final response = await _dioClient.dio.get<dynamic>(
        ApiConstants.historyUrl,
      );

      final statusCode = response.statusCode ?? 0;
      if (statusCode == 405) {
        throw const ServerFailure(
          'History is not available from this server (method not allowed).',
        );
      }
      if (statusCode == 404) {
        throw const ServerFailure(
          'Scan history is not available on this server.',
        );
      }
      if (statusCode >= 500) {
        throw const ServerFailure(
          'The scan service is temporarily unavailable. Please try again soon.',
        );
      }
      if (statusCode >= 400) {
        throw ServerFailure(
          _extractErrorDetail(response.data) ??
              'Could not load history ($statusCode).',
        );
      }

      final raw = response.data;
      if (raw == null) return <ScanModel>[];
      if (raw is! List<dynamic>) {
        throw const UnknownFailure(
          'We could not load history. Please try again.',
        );
      }

      return raw.map((dynamic item) {
        if (item is! Map<String, dynamic>) {
          throw const UnknownFailure(
            'We could not read an item in your history.',
          );
        }
        return ScanModel.fromJson(_normalizePredictResponse(item));
      }).toList();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } on Failure {
      rethrow;
    } catch (_) {
      throw const UnknownFailure(
        'Could not load history. Please try again.',
      );
    }
  }

  Failure _mapDioException(DioException e) {
    final responseSnippet =
        '${e.message ?? ''} ${_flattenBody(e.response?.data)}';
    if (_containsNgrokTunnelError(responseSnippet)) {
      return NetworkFailure(_ngrokOfflineMessage());
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const TimeoutFailure(
        'The request timed out. Check your connection and try again.',
      );
    }

    if (e.error is SocketException) {
      return const NetworkFailure(
        'Could not connect to the server. It may be offline or unreachable.',
      );
    }

    if (e.type == DioExceptionType.connectionError) {
      return const NetworkFailure(
        'Could not reach the scan service. Your network may be offline or the '
        'backend may be down.',
      );
    }

    if (e.type == DioExceptionType.badCertificate) {
      return const NetworkFailure(
        'Secure connection failed. Check your network or try another connection.',
      );
    }

    final code = e.response?.statusCode;
    if (code != null && code >= 500) {
      return const ServerFailure(
        'The scan service is temporarily unavailable. The backend may be offline.',
      );
    }
    if (code == 404) {
      return const ServerFailure(
        'The scan service was not found (404). Check the API base URL.',
      );
    }
    if (code == 405) {
      return const ServerFailure(
        'This request method is not allowed (405). The API may have changed.',
      );
    }
    if (code != null && code >= 400) {
      final body = e.response?.data;
      if (_containsNgrokTunnelError(_flattenBody(body))) {
        return NetworkFailure(_ngrokOfflineMessage());
      }
      return ServerFailure(
        _extractErrorDetail(body) ??
            'The server could not complete this scan ($code).',
      );
    }

    return const UnknownFailure(
      'Could not complete the scan. Please try again.',
    );
  }

  /// ngrok free tier / tunnel offline (HTML error pages include this code).
  bool _containsNgrokTunnelError(String? text) {
    if (text == null || text.isEmpty) return false;
    final u = text.toUpperCase();
    return u.contains('ERR_NGROK_3200') ||
        u.contains('ENDPOINT_IS_OFFLINE');
  }

  String _flattenBody(dynamic data) {
    if (data == null) return '';
    if (data is String) return data;
    return data.toString();
  }

  String _ngrokOfflineMessage() =>
      'The ngrok tunnel is offline or not reachable (ERR_NGROK_3200). '
      'Start the tunnel and confirm the base URL.';

  String _messageForUnexpectedBody(String raw) {
    if (_containsNgrokTunnelError(raw)) {
      return _ngrokOfflineMessage();
    }
    return 'The server returned an unexpected response. '
        'If you use ngrok, ensure the tunnel is running.';
  }

  String? _messageForHttpBody(int statusCode, dynamic data) {
    final flat = _flattenBody(data);
    if (_containsNgrokTunnelError(flat)) {
      return _ngrokOfflineMessage();
    }
    return _extractErrorDetail(data);
  }

  String _sanitizeUnexpectedError(Object _) =>
      'Something went wrong. Please try again.';

  String? _extractErrorDetail(dynamic data) {
    if (data is Map<String, dynamic>) {
      final detail = data['detail'] ?? data['message'] ?? data['error'];
      if (detail != null) return detail.toString();
    }
    if (data is String && data.trim().isNotEmpty) return data;
    return null;
  }

  Map<String, dynamic> _normalizePredictResponse(Map<String, dynamic> raw) {
    final json = Map<String, dynamic>.from(raw);

    final url = json['url']?.toString() ?? '';
    json['url'] = url;

    final verdictRaw = json['verdict'] ?? json['label'] ?? '';
    json['verdict'] = _normalizeVerdict(verdictRaw.toString());

    final riskRaw = json['risk_level'] ?? json['riskLevel'] ?? 'unknown';
    json['risk_level'] = _normalizeRiskLevel(riskRaw.toString());

    var confidence = (json['confidence'] as num?)?.toDouble() ?? 0.0;
    if (confidence > 1.0) confidence /= 100.0;
    json['confidence'] = confidence.clamp(0.0, 1.0);

    json['id'] = json['id']?.toString() ??
        '${url.hashCode}_${DateTime.now().millisecondsSinceEpoch}';

    json['scanned_at'] = json['scanned_at'] ??
        json['scannedAt'] ??
        DateTime.now().toIso8601String();

    json['engine'] = json['engine']?.toString() ?? '';

    final signalsRaw = json['signals'] ?? json['threats'];
    if (signalsRaw is List) {
      json['signals'] = signalsRaw.map((e) => e.toString()).toList();
    } else {
      json['signals'] = <String>[];
    }

    return json;
  }

  static String _normalizeVerdict(String raw) {
    final v = raw.trim().toUpperCase();
    if (v.contains('PHISH')) return 'PHISHING';
    if (v == 'SAFE' || v.contains('SAFE')) return 'SAFE';
    if (v == 'SUSPICIOUS') return 'SUSPICIOUS';
    return v.isEmpty ? 'UNKNOWN' : v;
  }

  static String _normalizeRiskLevel(String raw) {
    final r = raw.trim().toUpperCase();
    if (r == 'HIGH' || r == 'LOW') return r;
    final lower = raw.toLowerCase();
    if (lower == 'high') return 'HIGH';
    if (lower == 'low') return 'LOW';
    return r.isEmpty ? 'UNKNOWN' : r;
  }
}
