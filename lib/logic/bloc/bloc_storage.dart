import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei/data/api/API.dart';
import 'package:unmei/data/repository/news_repo.dart';
import 'package:unmei/logic/cubit/news/news_cubit.dart';
import 'package:unmei/logic/cubit/novels/novels_cubit.dart';
import 'package:unmei/presentation/page/home_page.dart';

Widget createBloc() => SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NewsCubit>(
            create: (context) => NewsCubit(NewsRepository(API(Dio()))),
          ),
          BlocProvider<NovelsCubit>(
            create: (context) => NovelsCubit(),
          ),
        ],
        child: HomePage(),
      ),
    );
