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

  Map<String, dynamic> toMap() {
    return {
      'loading': this.loading,
      'news': this.news,
      'error': this.error,
    };
  }

  factory NewsState.fromMap(Map<String, dynamic> map) {
    return NewsState(
      loading: map['loading'] as bool,
      news: map['news'] as List<NewsData>,
      error: map['error'] as String,
    );
  }
}