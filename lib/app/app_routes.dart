import 'package:seafarer/seafarer.dart';
import 'package:unmei/presentation/screen/registration_screen.dart';
import 'package:unmei/presentation/page/news_page.dart';
import 'package:unmei/presentation/page/novel_page.dart';
import 'package:unmei/presentation/page/settings_page.dart';
import 'package:unmei/presentation/screen/account_screen.dart';
import 'package:unmei/presentation/screen/novel_screen.dart';

class AppRouter {
  static final seafarer = Seafarer();

  void createRoutes() {
    seafarer.addRoutes(pageRoutes);
    seafarer.addRoutes(screenRoutes);
  }

  List<SeafarerRoute> pageRoutes = [
    SeafarerRoute(
      name: "/news",
      builder: (context, args, params) => NewsPage(),
    ),
    SeafarerRoute(
      name: "/novels",
      builder: (context, args, params) => NovelsPage(),
    ),
    SeafarerRoute(
      name: "/settings",
      builder: (context, args, params) => SettingsPage(),
    ),
  ];

  List<SeafarerRoute> screenRoutes = [
    SeafarerRoute(
      name: "/novel_screen",
      builder: (context, args, params) => NovelScreen(),
      params: [
        SeafarerParam<int>(name: 'index', defaultValue: 0),
      ],
    ),
    SeafarerRoute(
      name: "/registration_screen",
      builder: (context, args, params) => RegistrationScreen(),
    ),
    SeafarerRoute(
      name: "/account_screen",
      builder: (context, args, params) => AccountScreen(),
      // params: [
      //   SeafarerParam<int>(name: 'index', defaultValue: 0),
      // ],
    ),
  ];
}
