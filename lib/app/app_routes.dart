import 'package:seafarer/seafarer.dart';
import 'package:unmei/presentation/page/account_page.dart';
import 'package:unmei/presentation/page/news_page.dart';
import 'package:unmei/presentation/page/novel_page.dart';
import 'package:unmei/presentation/page/settings_page.dart';
import 'package:unmei/presentation/screen/novel_screen.dart';

class AppRouter {
  static final seafarer = Seafarer();

  static void createRoutes() {
    seafarer.addRoutes([
      SeafarerRoute(
        name: "/news",
        builder: (context, args, params) => NewsPage(),
      ),
      SeafarerRoute(
        name: "/novels",
        builder: (context, args, params) => NovelsPage(),
      ),
      SeafarerRoute(
        name: "/novel_screen",
        builder: (context, args, params) => NovelScreen(),
        params: [
          SeafarerParam<int>(name: 'index', defaultValue: 0),
        ],
      ),
      SeafarerRoute(
        name: "/account",
        builder: (context, args, params) => AccountPage(),
      ),
      SeafarerRoute(
        name: "/settings",
        builder: (context, args, params) => SettingsPage(),
      ),
    ]);
  }
}
