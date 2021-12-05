import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seafarer/seafarer.dart';
import 'package:unmei/app/app_routes.dart';

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        title: Text("Настройки", style: TextStyle(fontSize: 32, color: Colors.black)),
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
                    "/account_screen",
                    transitionDuration: Duration(milliseconds: 300),
                    transitions: [
                      SeafarerTransition.slide_from_right,
                    ],
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.grey[100]),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      "RonFall",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    subtitle: Text(
                      "Android dev.",
                      style: TextStyle(fontSize: 18, color: Color(0xFF0073FF)),
                    ),
                    leading: SvgPicture.asset('assets/icons/user.svg'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    contentPadding: EdgeInsets.all(0),
                  ),
                ),
              ),
              SizedBox(height: 8),
              settingsItem(
                name: "Темный режим",
                tooltip: 'Если включено, меняет все оформление приложения в темные тона.',
                iconAvatar: Icon(Icons.dark_mode_rounded, color: Colors.white),
                colorAvatar: Color(0xFF191919),
                trailing: Switch(
                  value: switchNotificationsBtn,
                  onChanged: (s) {},
                  activeColor: Color(0xFFeb3838),
                ),
              ),
              Divider(height: 0, thickness: 2),
              settingsItem(
                name: "Уведомлять о новостях",
                tooltip: 'Присылает пуш-уведомление, когда выходит новость.',
                iconAvatar: Icon(Icons.receipt_long_rounded, color: Colors.white),
                colorAvatar: Color(0xFF7AB9FF),
                trailing: Switch(
                  value: switchNotificationsBtn,
                  onChanged: (s) {},
                  activeColor: Color(0xFFeb3838),
                ),
              ),
              Divider(height: 0, thickness: 2),
              settingsItem(
                name: "Уведомлять о новеллах",
                tooltip: 'Присылает пуш-уведомление, когда добавляется новелла.',
                iconAvatar: Icon(Icons.auto_stories_rounded, color: Colors.white),
                colorAvatar: Color(0xFFE864FB),
                trailing: Switch(
                  value: switchNotificationsBtn,
                  onChanged: (s) {},
                  activeColor: Color(0xFFeb3838),
                ),
              ),
              Divider(height: 0, thickness: 2),
              settingsItem(
                name: "Уведомлять о обновлениях",
                tooltip: 'Присылает пуш-уведомление, когда необходимо обновить приложение.',
                iconAvatar: Icon(Icons.now_widgets_rounded, color: Colors.white),
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

  Widget settingsItem({
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
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(name, style: TextStyle(fontSize: 16, color: Colors.black)),
          leading: Container(
            margin: EdgeInsets.only(left: 8),
            child: CircleAvatar(backgroundColor: colorAvatar, child: iconAvatar),
          ),
          trailing: trailing,
          contentPadding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
