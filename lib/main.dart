import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unmei/presentation/page/home_page.dart';
import 'package:unmei/presentation/theme.dart';

import 'app/app_routes.dart';
import 'data/hive_storage.dart';
import 'logic/bloc/bloc_storage.dart';

void main() async {
  AppRouter.createRoutes();
  await HiveStorage().init();
  runApp(App());
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
          child: AdaptiveTheme(
            initial: AdaptiveThemeMode.light,
            light: lightTheme,
            dark: darkTheme,
            builder: (light, dark) => MaterialApp(
              theme: light,
              darkTheme: dark,
              debugShowCheckedModeBanner: false,
              navigatorKey: AppRouter.seafarer.navigatorKey,  // important
              onGenerateRoute: AppRouter.seafarer.generator(),
              home: SafeArea(child: HomePage()),
            ),
          ),
        );
      },
    );
  }
}
