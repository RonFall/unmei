import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei/data/model/news_model.dart';
import 'package:unmei/logic/cubit/news/news_cubit.dart';
import 'package:unmei/presentation/widget/loader_widget.dart';
import 'package:unmei/presentation/widget/utils_widget.dart';
import 'package:unmei/app/utils.dart';

class NewsPage extends StatelessWidget {
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
          "Новости",
          style: TextStyle(
            fontSize: 32,
            color: Theme.of(context).highlightColor,
          ),
        ),
      ),
      body: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state.error != null) {
            return showLoginError(context, error: state.error!);
          }
        },
        builder: (context, state) {
          if (state.loading) return buildNewsItemShimmer();
          if (state.news != null) {
            return buildNewsItem(context: context, news: state.news);
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/error.png',
                  height: MediaQuery.of(context).size.height / 3,
                ),
                Text(
                  "Что-то пошло не так D:",
                  style: TextStyle(color: Theme.of(context).highlightColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildNewsItem({
    required BuildContext context,
    required List<NewsData>? news,
  }) {
    final cubit = BlocProvider.of<NewsCubit>(context);
    return LoaderWidget(
      indicatorColor: Color(0xFF0E4DA4),
      onRefresh: () {
        Future.delayed(Duration(milliseconds: 1500), () {
          context.read<NewsCubit>().loadData();
          news!.forEach((element) {
            print("Title ${element.title} has ${element.shortPost.length}");
          });
        });
      },
      child: ListView.separated(
        itemCount: news!.length,
        padding: EdgeInsets.all(16),
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          final size = news[index].shortPost.length;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).cardColor,
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
                    color: Theme.of(context).highlightColor,
                  ),
                ),
                SizedBox(height: 16),
                AnimatedSize(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInBack,
                  child: ConstrainedBox(
                    constraints: cubit.state.hasPaperOpen
                        ? BoxConstraints()
                        : BoxConstraints(maxHeight: 50.0),
                    child: Text(
                      "${news[index].shortPost}",
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (size > 150) cubit.changeOpenState();
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: Color(0xFF0E4DA4),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                        overlayColor: MaterialStateProperty.all(
                          Color(0xFFC7DBFF),
                        ),
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
                            Icon(
                              Icons.account_circle,
                              size: 18,
                              color: Theme.of(context).highlightColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${news[index].author}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              size: 18,
                              color: Theme.of(context).highlightColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${setDateTime(news[index].date)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Theme.of(context).highlightColor,
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
    );
  }

  Widget buildNewsItemShimmer() {
    return ListView.separated(
      itemCount: 10,
      padding: EdgeInsets.all(16),
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                onBoxShim(
                  context: context,
                  height: 24,
                  width: 196,
                  radius: 16,
                ),
                SizedBox(height: 16),
                onBoxShim(
                  context: context,
                  height: 64,
                  width: 256,
                  radius: 16,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    onBoxShim(
                      context: context,
                      height: 48,
                      width: 128,
                      radius: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        onBoxShim(
                          context: context,
                          height: 16,
                          width: 96,
                          radius: 16,
                        ),
                        SizedBox(height: 8),
                        onBoxShim(
                          context: context,
                          height: 16,
                          width: 128,
                          radius: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
