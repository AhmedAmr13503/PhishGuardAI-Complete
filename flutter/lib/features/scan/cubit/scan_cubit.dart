import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failures.dart';
import '../data/scan_repository.dart';
import 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit(this._repository) : super(const ScanState.initial());

  final ScanRepository _repository;

  Future<void> scanUrl(String url) async {
    emit(const ScanState.loading());
    try {
      final result = await _repository.scanUrl(url);
      emit(ScanState.success(result));
    } on Failure catch (e) {
      emit(ScanState.failure(e.message));
    } catch (_) {
      emit(
        const ScanState.failure(
          'Something went wrong. Please try again.',
        ),
      );
    }
  }

  Future<void> getHistory() async {
    emit(const ScanState.loading());
    try {
      final history = await _repository.getScanHistory();
      emit(ScanState.historyLoaded(history));
    } on Failure catch (e) {
      emit(ScanState.failure(e.message));
    } catch (_) {
      emit(
        const ScanState.failure(
          'Could not load history. Please try again.',
        ),
      );
    }
  }

  void reset() {
    emit(const ScanState.initial());
  }
}
