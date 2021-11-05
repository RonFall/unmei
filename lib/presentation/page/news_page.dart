import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei/data/model/news_model.dart';
import 'package:unmei/logic/cubit/news/news_cubit.dart';
import 'package:unmei/presentation/widget/loader_widget.dart';
import 'package:unmei/presentation/widget/utils_widget.dart';
import 'package:unmei/utils.dart';

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool hasOpen = false;

  @override
  void initState() {
    context.read<NewsCubit>().loadData();
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
        title: Text("Новости",
            style: TextStyle(fontSize: 32, color: Colors.black)),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          BlocConsumer<NewsCubit, NewsState>(
            listener: (context, state) {
              if (state.error != null) return showLoginError(context, error: state.error!);
            },
            builder: (context, state) {
              if (state.loading) return buildNewsItemShimmer();
              if (state.news != null) return buildNewsItem(context: context, news: state.news);
              return Center(
                child: Text("Что-то пошло не так D:"),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildNewsItem({required BuildContext context, required List<NewsData>? news}) => Expanded(
        child: LoaderWidget(
          indicatorColor: Color(0xFF0E4DA4),
          onRefresh: () {
            Future.delayed(Duration(milliseconds: 1500), () {
              context.read<NewsCubit>().loadData();
              news!.forEach((element) {
                print("Title ${element.title} has ${element.shortPost.length}");
              });
            });
          },
          child: ListView.builder(
            itemCount: news!.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              var size = news[index].shortPost.length;
              return Container(
                margin: EdgeInsets.only(
                  top: index == 0 ? 0 : 16,
                  right: 16,
                  left: 16,
                  bottom: index == news.length - 1 ? 16 : 0,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                      offset: Offset(2.0, 2.0),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${news[index].title}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    AnimatedSize(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInBack,
                      child: ConstrainedBox(
                        constraints: hasOpen
                            ? BoxConstraints()
                            : BoxConstraints(maxHeight: 50.0),
                        child: Text(
                          "${news[index].shortPost}",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFF263238)),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (size > 150) {
                              setState(() {
                                hasOpen = !hasOpen;
                              });
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xFF0E4DA4)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            overlayColor:
                                MaterialStateProperty.all(Color(0xFFC7DBFF)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child: Text(
                            "Подробнее",
                            style: TextStyle(color: Color(0xFF0E4DA4)),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.account_circle,
                                    size: 18, color: Colors.black),
                                SizedBox(width: 4),
                                Text(
                                  "${news[index].author}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.date_range,
                                    size: 18, color: Colors.black),
                                SizedBox(width: 4),
                                Text(
                                  "${setDateTime(news[index].date)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

  Widget buildNewsItemShimmer() => Expanded(
        child: ListView.builder(
          itemCount: 10,
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) => Card(
            margin: EdgeInsets.only(
              top: index == 0 ? 0 : 16,
              left: 16,
              right: 16,
              bottom: index == 9 ? 16 : 0,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  onBoxShim(height: 24, width: 196, radius: 16),
                  SizedBox(height: 16),
                  onBoxShim(height: 64, width: 256, radius: 16),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      onBoxShim(height: 48, width: 128, radius: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          onBoxShim(height: 16, width: 96, radius: 16),
                          SizedBox(height: 8),
                          onBoxShim(height: 16, width: 128, radius: 16),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}