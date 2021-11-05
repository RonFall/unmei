part of 'news_cubit.dart';

class NewsState {
  final bool loading;
  final List<NewsData>? news;
  final String? error;

  NewsState({
    this.loading = false,
    this.news,
    this.error,
  });
}
