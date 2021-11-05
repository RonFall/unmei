import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unmei/presentation/theme.dart';

import 'app_route.dart';
import 'logic/bloc/bloc_storage.dart';

void main() async {
  // await HiveStorage().init();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

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
        return AdaptiveTheme(
          initial: AdaptiveThemeMode.light,
          light: lightTheme,
          dark: darkTheme,
          builder: (light, dark) => MaterialApp(
            onGenerateRoute: AppRouter().onGenerateRoute,
            theme: light,
            darkTheme: dark,
            debugShowCheckedModeBanner: false,
            home: createBloc(),
          ),
        );
      },
    );
  }
}
