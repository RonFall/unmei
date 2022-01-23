import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unmei/presentation/page/home_page.dart';

import 'app/app_routes.dart';
import 'app/presentation/app_themes.dart';
import 'data/hive_storage.dart';
import 'logic/bloc/bloc_storage.dart';
import 'logic/cubit/settings/settings_cubit.dart';

void main() async {
  AppRouter().createRoutes();
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorage().init();
  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(() => runApp(App()), storage: storage);
}

class Init {
  Init._();

  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(microseconds: 500));
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(color: Color(0xFF18182F)),
              ),
            ),
          );
        }
        return MultiBlocProvider(
          providers: blocList,
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              final cubit = context.read<SettingsCubit>();
              return MaterialApp(
                theme: appThemeData[cubit.state.theme],
                debugShowCheckedModeBanner: false,
                navigatorKey: AppRouter.seafarer.navigatorKey,
                onGenerateRoute: AppRouter.seafarer.generator(),
                home: SafeArea(child: HomePage()),
              );
            },
          ),
        );
      },
    );
  }
}
