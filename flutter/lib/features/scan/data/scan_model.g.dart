// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScanModelImpl _$$ScanModelImplFromJson(Map<String, dynamic> json) =>
    _$ScanModelImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      verdict: json['verdict'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      riskLevel: json['risk_level'] as String,
      scannedAt: DateTime.parse(json['scanned_at'] as String),
      engine: json['engine'] as String? ?? '',
      signals: (json['signals'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$ScanModelImplToJson(_$ScanModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'verdict': instance.verdict,
      'confidence': instance.confidence,
      'risk_level': instance.riskLevel,
      'scanned_at': instance.scannedAt.toIso8601String(),
      'engine': instance.engine,
      'signals': instance.signals,
    };
