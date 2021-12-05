import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seafarer/seafarer.dart';
import 'package:unmei/app/utils.dart';
import 'package:unmei/data/model/novels_item_model.dart';
import 'package:unmei/logic/cubit/novels/item/novels_item_cubit.dart';

class NovelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final index = Seafarer.param<int>(context, 'index');
    context.read<NovelsItemCubit>().getNovel(index!);
    return Scaffold(
      body: BlocConsumer<NovelsItemCubit, NovelsItemState>(
        listener: (context, state) {
          if (state.error != null) throw Exception(state.error);
        },
        builder: (context, state) {
          if (state.loading) return Center(child: CircularProgressIndicator());
          if (state.novel != null) return buildNovel(context, state.novel!);
          return Center(child: Text("Что-то пошло не так D:"));
        },
      ),
    );
  }

  Widget buildNovel(BuildContext context, NovelsItemData novel) => ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            color: Color(0xFFa338eb),
            child: Column(
              children: [
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, size: 18, color: Colors.white),
                      SizedBox(width: 4),
                      Text("Назад", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: novel.image.length > 10 ? Image.network(novel.image) : Image.asset("assets/images/no_image.png"),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          novel.originalName,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          novel.localizedName,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xFFe3983d),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 22, color: Colors.white),
                          SizedBox(width: 2),
                          Text(
                            novel.rating.toString(),
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF155ad1),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
                ),
                child: Text(
                  "Краткая справка: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Card(
            elevation: 8,
            margin: EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textStyle("Выпуск: ", "${setDateTime(novel.releaseDate)}"),
                  novel.genres.isEmpty ? SizedBox() : genresConvert("Жанры: ", novel.genres),
                  novel.duration == 0 ? SizedBox() : textStyle("Продолжительность: ", "${novel.duration}"),
                  textStyle("Статус: ", "${statusConvert(novel.exitStatus)}"),
                  novel.platforms.isEmpty ? SizedBox() : textStyle("Платформы: ", "${novel.platforms}"),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFd12b15),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
                ),
                child: Text(
                  "Описание: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Card(
            elevation: 8,
            margin: EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Container(
              margin: EdgeInsets.all(16),
              child: Text(
                "${novel.description}",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      );

  Widget platformConvert(String text) {
    List<Widget> asset = [];
    var widgetMap = {
      'win': "assets/icons/platform/win.svg",
      // 'mac': "assets/icons/platform/mac.svg",
      'linux': "assets/icons/platform/linux.svg",
      'ios': "assets/icons/platform/ios.svg",
      'android': "assets/icons/platform/android.svg",
    };
    widgetMap.forEach((platform, path) {
      if (text.contains(platform)) {
        asset.add(
          Container(
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.only(right: 4),
            decoration: BoxDecoration(color: Color(0xFF9915d1)),
            child: SvgPicture.asset(path, height: 16, color: Colors.white),
          ),
        );
      }
    });
    return Row(children: asset);
  }

  Widget genresConvert(String textMain, List<Genres>? genres) {
    String? genreName = '';
    List<Widget> genreWidget = [];
    var genresMap = {
      'romantic': 'Романтика',
      'fantasy': 'Фэнтези',
      'horror': 'Ужасы',
      'yaoi': 'Яой',
      'yuri': 'Юри',
    };

    genres!.forEach((genre) {
      var key = genre.name;
      genreName = genresMap[key];
      genreWidget.add(
        Container(
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.only(right: 4),
          decoration: BoxDecoration(color: Color(0xFF9915d1)),
          child: Text(genreName!),
        ),
      );
    });

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            textMain,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF155ad1)),
          ),
          Row(children: genreWidget),
        ],
      ),
    );
  }

  String statusConvert(String text) {
    if (text == "in_developing") return "В разработке";
    if (text == "came_out") return "Вышло";
    if (text == "canceled") return "Отменено";
    if (text == "announcement") return "Анонс";
    if (text == "postponed") return "Перенесено";
    return "";
  }

  Widget textStyle(String textMain, String textDesc) => Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Text(
              textMain,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF155ad1)),
            ),
            if (textMain == "Платформы: ")platformConvert(textDesc)
            else Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(color: Color(0xFF9915d1)),
                child: Text(
                  textDesc,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
          ],
        ),
      );
}
