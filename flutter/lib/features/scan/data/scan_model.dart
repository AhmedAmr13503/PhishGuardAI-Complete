import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_model.freezed.dart';
part 'scan_model.g.dart';

@freezed
class ScanModel with _$ScanModel {
  const factory ScanModel({
    required String id,
    required String url,
    required String verdict,
    required double confidence,
    @JsonKey(name: 'risk_level') required String riskLevel,
    @JsonKey(name: 'scanned_at') required DateTime scannedAt,
    @Default('') String engine,
    @Default(<String>[]) List<String> signals,
  }) = _ScanModel;

  factory ScanModel.fromJson(Map<String, dynamic> json) =>
      _$ScanModelFromJson(json);
}
