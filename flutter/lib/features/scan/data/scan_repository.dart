import '../../../core/errors/failures.dart';
import 'scan_api_service.dart';
import 'scan_model.dart';

class ScanRepository {
  final ScanApiService _apiService;

  ScanRepository(this._apiService);

  Future<ScanModel> scanUrl(String url) async {
    try {
      return await _apiService.scanUrl(url);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Repository error: $e');
    }
  }

  Future<List<ScanModel>> getScanHistory() async {
    try {
      return await _apiService.getScanHistory();
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Repository error: $e');
    }
  }
}
