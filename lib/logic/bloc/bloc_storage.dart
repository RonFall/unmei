import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei/logic/cubit/news/news_cubit.dart';
import 'package:unmei/logic/cubit/novels/item/novels_item_cubit.dart';
import 'package:unmei/logic/cubit/novels/novels_cubit.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:unmei/logic/cubit/settings/settings_cubit.dart';

final List<BlocProviderSingleChildWidget> blocList = [
  BlocProvider<NewsCubit>(
    create: (context) => NewsCubit(),
  ),
  BlocProvider<NovelsCubit>(
    create: (context) => NovelsCubit(),
  ),
  BlocProvider<NovelsItemCubit>(
    create: (context) => NovelsItemCubit(),
  ),
  BlocProvider<SettingsCubit>(
    create: (context) => SettingsCubit(),
  ),
];
