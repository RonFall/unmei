part of 'news_cubit.dart';

class NewsState {
  final bool loading;
  final bool hasPaperOpen;
  final List<NewsData>? news;
  final String? error;

  NewsState({
    this.loading = false,
    this.hasPaperOpen = false,
    this.news,
    this.error,
  });
}
