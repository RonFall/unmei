import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seafarer/seafarer.dart';
import 'package:unmei/app/app_routes.dart';
import 'package:unmei/presentation/widget/settings_modal_widget.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var switchNotificationsBtn = false;

  @override
  void initState() {
    super.initState();
  }

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
          "Настройки",
          style: TextStyle(
            fontSize: 32,
            color: Theme.of(context).highlightColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  AppRouter.seafarer(
                    "/registration_screen",
                    transitionDuration: Duration(milliseconds: 300),
                    transitions: [
                      SeafarerTransition.slide_from_right,
                    ],
                  );
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                    Theme.of(context).cardColor,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      "RonFall",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                    subtitle: Text(
                      "Android dev.",
                      style: TextStyle(fontSize: 18, color: Color(0xFF0073FF)),
                    ),
                    leading: SvgPicture.asset('assets/icons/user.svg'),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Theme.of(context).backgroundColor,
                    ),
                    contentPadding: EdgeInsets.all(0),
                  ),
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    context: context,
                    builder: (_) {
                      return SettingsModalWidget();
                    },
                  );
                },
                child: tooltipSettingsItem(
                  name: "Выбрать тему",
                  tooltip:
                      'Если включено, меняет все оформление приложения в тона выбранной темы.',
                  trailing: Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  iconAvatar: Icon(
                    Icons.dark_mode_rounded,
                    color: Colors.white,
                  ),
                  colorAvatar: Color(0xFF191919),
                ),
              ),
              tooltipSettingsItem(
                name: "Уведомлять о новостях",
                tooltip: 'Присылает пуш-уведомление, когда выходит новость.',
                iconAvatar: Icon(
                  Icons.receipt_long_rounded,
                  color: Colors.white,
                ),
                colorAvatar: Color(0xFF7AB9FF),
                trailing: Switch(
                  value: switchNotificationsBtn,
                  onChanged: (s) {},
                  activeColor: Color(0xFFeb3838),
                ),
              ),
              tooltipSettingsItem(
                name: "Уведомлять о новеллах",
                tooltip:
                    'Присылает пуш-уведомление, когда добавляется новелла.',
                iconAvatar: Icon(
                  Icons.auto_stories_rounded,
                  color: Colors.white,
                ),
                colorAvatar: Color(0xFFE864FB),
                trailing: Switch(
                  value: switchNotificationsBtn,
                  onChanged: (s) {},
                  activeColor: Color(0xFFeb3838),
                ),
              ),
              tooltipSettingsItem(
                name: "Уведомлять о обновлениях",
                tooltip:
                    'Присылает пуш-уведомление, когда необходимо обновить приложение.',
                iconAvatar: Icon(
                  Icons.now_widgets_rounded,
                  color: Colors.white,
                ),
                colorAvatar: Colors.blue,
                trailing: Switch(
                  value: switchNotificationsBtn,
                  onChanged: (s) {},
                  activeColor: Color(0xFFeb3838),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget tooltipSettingsItem({
    required String name,
    required Icon iconAvatar,
    String tooltip = '',
    Widget trailing = const SizedBox(),
    Color colorAvatar = Colors.black,
  }) {
    return Tooltip(
      message: tooltip,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: settingsItem(
        iconAvatar: iconAvatar,
        name: name,
        trailing: trailing,
        colorAvatar: colorAvatar,
      ),
    );
  }

  Widget settingsItem({
    required String name,
    required Icon iconAvatar,
    Widget trailing = const SizedBox(),
    Color colorAvatar = Colors.black,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).indicatorColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).highlightColor,
          ),
        ),
        leading: Container(
          margin: EdgeInsets.only(left: 8),
          child: CircleAvatar(backgroundColor: colorAvatar, child: iconAvatar),
        ),
        trailing: trailing,
        contentPadding: EdgeInsets.all(0),
      ),
    );
  }
}
