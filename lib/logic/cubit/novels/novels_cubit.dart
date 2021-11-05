import 'package:bloc/bloc.dart';
import 'package:unmei/data/api/API.dart';
import 'package:unmei/data/model/novels_item_model.dart';
import 'package:unmei/data/model/novels_model.dart';

part 'novels_state.dart';

class NovelsCubit extends Cubit<NovelsState> {
  final api = API();

  NovelsCubit() : super(NovelsState());

  @override
  void onChange(Change<NovelsState> change) {
    print("NEWS CHANGE: ${change}");
    super.onChange(change);
  }

  void onNovelsLoad({String name = ''}) async {
    emit(NovelsState(loading: true));
    api.getNetworkData(cls: Novels(), type: 'novels?q=$name').then((novels) {
      emit(NovelsState(novels: novels.data));
    }).catchError((error) {
      emit(NovelsState(error: error.toString()));
    });
  }

  void getNovel(int index) async {
    emit(NovelsItemState(loading: true));
    api.getNetworkData(cls: NovelsItem(), type: 'novels/$index').then((novels) {
      emit(NovelsItemState(novel: novels.data));
    }).catchError((error) {
      emit(NovelsItemState(error: error.toString()));
    });
  }
}
