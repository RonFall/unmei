part of 'novels_cubit.dart';

class NovelsState {
  final bool loading;
  final List<NovelsData>? novels;
  final String? error;

  NovelsState({
    this.loading = false,
    this.novels,
    this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      'loading': this.loading,
      'novels': this.novels,
      'error': this.error,
    };
  }

  factory NovelsState.fromMap(Map<String, dynamic> map) {
    return NovelsState(
      loading: map['loading'] as bool,
      novels: map['novels'] as List<NovelsData>,
      error: map['error'] as String,
    );
  }
}

