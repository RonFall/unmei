import 'package:flutter_request_bloc/cubits/request_persistant_cubit.dart';
import 'package:flutter_request_bloc/cubits/request_state.dart';
import 'package:unmei/data/model/news_model.dart';
import 'package:unmei/data/repository/news_repo.dart';

part 'news_state.dart';

class NewsCubit extends RequestPersistantCubit<NewsRepository, dynamic>{
  NewsCubit(NewsRepository repository) : super(repository);

  @override
  Future<void> loadData() async {
    emit(RequestState.loading(state.value));
    try {
      final data = await repository.fetchData();
      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e.toString()));
    }
  }
}
