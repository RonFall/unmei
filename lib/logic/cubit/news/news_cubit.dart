import 'package:bloc/bloc.dart';
import 'package:unmei/data/api/API.dart';
import 'package:unmei/data/model/news_model.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final api = API();

  NewsCubit() : super(NewsState()) {
    loadData();
  }

  @override
  void onChange(Change<NewsState> change) {
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    throw Exception(error);
  }

  void loadData() async {
    emit(NewsState(loading: true));
    api.getNetworkData(cls: News(), type: 'news').then((news) {
      emit(NewsState(news: news.data));
    }).catchError((error) {
      emit(NewsState(error: error.toString()));
    });
  }

  void changeOpenState() {
    if (state.hasPaperOpen) {
      emit(NewsState(hasPaperOpen: false, news: state.news));
    } else {
      emit(NewsState(hasPaperOpen: true, news: state.news));
    }
  }
}
