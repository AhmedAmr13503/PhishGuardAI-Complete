import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/scan_model.dart';

part 'scan_state.freezed.dart';

@freezed
class ScanState with _$ScanState {
  const factory ScanState.initial() = _Initial;
  const factory ScanState.loading() = _Loading;
  const factory ScanState.success(ScanModel result) = _Success;
  const factory ScanState.historyLoaded(List<ScanModel> history) =
      _HistoryLoaded;
  const factory ScanState.failure(String message) = _Failure;
}
