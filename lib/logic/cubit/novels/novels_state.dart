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
}

