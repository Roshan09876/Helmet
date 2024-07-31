import 'package:helmet/features/dash/domain/helmet_model.dart';


class HelmetState {
  final bool isLoading;
  final String? error;
  final List<HelmetModel>? helmetModle;

  HelmetState({
    required this.isLoading,
    this.error,
    this.helmetModle,
  });

  factory HelmetState.initial() {
    return HelmetState(isLoading: false, error: null, helmetModle: null);
  }

  HelmetState copyWith({
    bool? isLoading,
    String? error,
    List<HelmetModel>? helmetModle,
  }) {
    return HelmetState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      helmetModle: helmetModle ?? this.helmetModle,
    );
  }
}
