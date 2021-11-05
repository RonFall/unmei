import 'package:bloc/bloc.dart';
import 'package:unmei/data/api/API.dart';
import 'package:unmei/data/model/news_model.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final api = API();
  bool hasOpen = false;

  NewsCubit() : super(NewsState()) {
    loadData();
  }

  void loadData() async {
    emit(NewsState(loading: true));
    api.getNetworkData(cls: News(), type: 'news').then((news) {
      emit(NewsState(news: news.data));
    }).catchError((error) {
      emit(NewsState(error: error.toString()));
    });
  }
}
