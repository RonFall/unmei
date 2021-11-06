part of 'novels_item_cubit.dart';

class NovelsItemState {
  final bool loading;
  final NovelsItemData? novel;
  final String? error;

  NovelsItemState({
    this.loading = false,
    this.novel,
    this.error,
  });
}
