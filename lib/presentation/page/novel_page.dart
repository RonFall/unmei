import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seafarer/seafarer.dart';
import 'package:unmei/app/app_routes.dart';
import 'package:unmei/data/model/novels_model.dart';
import 'package:unmei/logic/cubit/novels/novels_cubit.dart';
import 'package:unmei/presentation/widget/loader_widget.dart';
import 'package:unmei/presentation/widget/textfield_widget.dart';
import 'package:unmei/presentation/widget/utils_widget.dart';

class NovelsPage extends StatefulWidget {
  @override
  State<NovelsPage> createState() => _NovelsPageState();
}

class _NovelsPageState extends State<NovelsPage> {
  late TextEditingController search;

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        title: Text(
          "Новеллы",
          style: TextStyle(
            fontSize: 32,
            color: Theme.of(context).highlightColor,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          TextFieldWidget(
            controller: search,
            hint: 'Новелла под названием...',
            textColor: Theme.of(context).highlightColor,
            fieldBarColor: Color(0xFFE864FB),
            fillColor: Theme.of(context).indicatorColor,
            onType: (text) {
              context.read<NovelsCubit>().onNovelsLoad(name: text);
            },
            onClear: () => context.read<NovelsCubit>().onNovelsLoad(),
          ),
          BlocConsumer<NovelsCubit, NovelsState>(
            listener: (context, state) {
              if (state.error != null) {
                return showLoginError(context, error: state.error!);
              }
            },
            builder: (context, state) {
              if (state.loading) return buildNovelItemShimmer();
              if (state.novels != null) {
                return buildNovelItem(context, state.novels);
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/error.png'),
                    Text(
                      "Что-то пошло не так D:",
                      style: TextStyle(color: Theme.of(context).highlightColor),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildNovelItem(BuildContext context, List<NovelsData>? novels) {
    return Expanded(
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16),
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
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
                AppRouter.seafarer(
                  "/novel_screen",
                  transitionDuration: Duration(milliseconds: 300),
                  transitions: [
                    SeafarerTransition.slide_from_right,
                  ],
                  params: {
                    'index': novels[index].id,
                  },
                );
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
                                      color: Theme.of(context).highlightColor,
                                    ),
                                  ),
                                  Text(
                                    novels[index].originalName,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Theme.of(context).highlightColor,
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
  }

  Widget buildNovelItemShimmer() {
    return Expanded(
      child: GridView.builder(
        itemCount: 14,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Container(
              height: 100,
              child: Column(
                children: [
                  Expanded(
                    child: onBoxShim(
                      context: context,
                      margin: EdgeInsets.all(8),
                      radius: 8,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        onBoxShim(
                          context: context,
                          height: 25,
                          width: 120,
                          radius: 16,
                        ),
                        onBoxShim(
                          context: context,
                          height: 20,
                          width: 140,
                          radius: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
