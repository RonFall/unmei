import 'package:bloc/bloc.dart';
import 'package:unmei/data/api/API.dart';
import 'package:unmei/data/model/novels_item_model.dart';

part 'novels_item_state.dart';

class NovelsItemCubit extends Cubit<NovelsItemState> {
  final api = API();

  NovelsItemCubit() : super(NovelsItemState());

  void getNovel(int index) async {
    emit(NovelsItemState(loading: true));
    api.getNetworkData(cls: NovelsItem(), type: 'novels/$index').then((novels) {
      emit(NovelsItemState(novel: novels.data));
    }).catchError((error) {
      emit(NovelsItemState(error: error.toString()));
    });
  }
}
