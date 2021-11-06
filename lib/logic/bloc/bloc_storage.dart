import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei/logic/cubit/news/news_cubit.dart';
import 'package:unmei/logic/cubit/novels/item/novels_item_cubit.dart';
import 'package:unmei/logic/cubit/novels/novels_cubit.dart';
import 'package:unmei/presentation/page/home_page.dart';

Widget createBloc() => SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NewsCubit>(
            create: (context) => NewsCubit(),
          ),
          BlocProvider<NovelsCubit>(
            create: (context) => NovelsCubit(),
          ),
          BlocProvider<NovelsItemCubit>(
            create: (context) => NovelsItemCubit(),
          ),
        ],
        child: HomePage(),
      ),
    );
