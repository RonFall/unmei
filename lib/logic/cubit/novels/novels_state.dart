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

class NovelsItemState extends NovelsState {
  final bool loading;
  final NovelsItemData? novel;
  final String? error;

  NovelsItemState({
    this.loading = false,
    this.novel,
    this.error,
  });
}

