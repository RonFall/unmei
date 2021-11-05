import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei/data/model/novels_model.dart';
import 'package:unmei/logic/cubit/novels/novels_cubit.dart';
import 'package:unmei/presentation/widget/loader_widget.dart';
import 'package:unmei/presentation/widget/textfield_widget.dart';
import 'package:unmei/presentation/widget/utils_widget.dart';

import '../../utils.dart';

class NovelsPage extends StatefulWidget {
  @override
  State<NovelsPage> createState() => _NovelsPageState();
}

class _NovelsPageState extends State<NovelsPage> {
  late TextEditingController search;

  @override
  void initState() {
    search = TextEditingController();
    context.read<NovelsCubit>().onNovelsLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        title: Text("Новеллы", style: TextStyle(fontSize: 32, color: Colors.black)),
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          TextFieldWidget(controller: search, hint: 'Новелла под названием...',),
          SizedBox(height: 8),
          BlocConsumer<NovelsCubit, NovelsState>(
            listener: (context, state) {
              if (state.error != null) return showLoginError(context, error: state.error!);
            },
            builder: (context, state) {
              if (state.loading) return buildNovelItemShimmer();
              if (state.novels != null) return buildNovelItem(context, state.novels);
              return Center(
                child: Text("Что-то пошло не так D:"),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildNovelItem(BuildContext context, List<NovelsData>? novels) =>
      Expanded(
        child: LoaderWidget(
          indicatorColor: Color(0xFF9915d1),
          boxSize: 150,
          onRefresh: () {
            Future.delayed(Duration(milliseconds: 1500), () {
              context.read<NovelsCubit>().onNovelsLoad();
            });
          },
          child: GridView.builder(
            itemCount: novels!.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(
                top: index == 0 && index == 1 ? 0 : 8,
                left: index % 2 == 0 ? 8 : 8,
                right: index % 2 == 0 ? 0 : 8,
                bottom: index == novels.length - 1 && index == novels.length - 2 ? 8 : 0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                    offset: Offset(2.0, 2.0),
                  )
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  print("GOTO");
                  // context.read(databaseNovelsProvider).initNovelsItem(index);
                  // store.dispatch(loadNovelsItemThunk(store, novels.data![index].id));
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 1)),
                            ),
                            child: Image.network(novels[index].image),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Color(0xFFe3983d),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    novels[index].rating.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 8, left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      novels[index].localizedName.length > 1
                                          ? novels[index].localizedName
                                          : "no name",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      novels[index].originalName,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF263238),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildNovelItemShimmer() => Expanded(
        child: GridView.builder(
          itemCount: 14,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) => Card(
            margin: EdgeInsets.only(
              top: index == 0 && index == 1 ? 0 : 8,
              left: index % 2 == 0 ? 8 : 8,
              right: index % 2 == 0 ? 0 : 8,
              bottom: index == 13 && index == 12 ? 8 : 0,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Container(
              height: 100,
              child: Column(
                children: [
                  Expanded(
                    child: onBoxShim(margin: EdgeInsets.all(8), radius: 8),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        onBoxShim(height: 25, width: 120, radius: 16),
                        onBoxShim(height: 20, width: 140, radius: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
