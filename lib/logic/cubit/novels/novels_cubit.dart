import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:unmei/data/api/API.dart';
import 'package:unmei/data/model/novels_model.dart';

part 'novels_state.dart';

class NovelsCubit extends HydratedCubit<NovelsState> {
  final api = API();

  NovelsCubit() : super(NovelsState()) {
    onNovelsLoad();
  }

  @override
  void onChange(Change<NovelsState> change) {
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    throw Exception(error);
  }

  void onNovelsLoad({String name = ''}) async {
    emit(NovelsState(loading: true));
    api.getNetworkData(cls: Novels(), type: 'novels?q=$name').then((novels) {
      emit(NovelsState(novels: novels.data));
    }).catchError((error) {
      emit(NovelsState(error: error.toString()));
    });
  }

  @override
  NovelsState? fromJson(Map<String, dynamic> json) {
    NovelsState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(NovelsState state) {
    state.toMap();
  }
}
