import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helmet/features/home/presentation/state/home_state.dart';

final homeviewmodelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel();
});

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(HomeState.initial());

  void changeIndex(int index) {
    state = state.copywith(index: index);
  }
}
