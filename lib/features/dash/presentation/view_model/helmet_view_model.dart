import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helmet/features/dash/data/helmet_remote_datasource.dart';
import 'package:helmet/features/dash/presentation/state/helmet_state.dart';


final helmetViewModelProvider =
    StateNotifierProvider<HelmetViewModel, HelmetState>((ref) {
  return HelmetViewModel(ref.read(helmetRemoteDatasourceProvider));
});

class HelmetViewModel extends StateNotifier<HelmetState> {
  final HelmetRemoteDatasource helmetRemoteDatasource;
  HelmetViewModel(this.helmetRemoteDatasource) : super(HelmetState.initial());

  Future<void> getHelmet() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(Duration(seconds: 1));
    final result = await helmetRemoteDatasource.getHelmet();
    result.fold((failure) {
      state = state.copyWith(
          isLoading: false, error: failure.error, helmetModle: null);
    }, (helmet) {
      state =
          state.copyWith(isLoading: false, helmetModle: helmet, error: null);
    });
  }
}
