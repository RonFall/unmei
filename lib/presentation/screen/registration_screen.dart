import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unmei/app/utils.dart';
import 'package:unmei/data/api/API.dart';
import 'package:unmei/presentation/widget/textfield_widget.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final TextEditingController loginController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    loginController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Column(
                    children: [
                      Card(
                        color: Color(0xFF1D1D36),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 48,
                          ),
                          child: Text(
                            "Unmei",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w100,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "С возвращением!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Войдите в свой аккаунт чтобы сохранять понравившиеся новеллы и оставлять отзывы. Это поможет развитию приложения, сайта и сообщества Unmei.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        hint: "Логин",
                        controller: loginController,
                        keyboardType: TextInputType.emailAddress,
                        fieldAction: TextInputAction.next,
                        next: true,
                        fillColor: Theme.of(context).indicatorColor,
                        fieldBarColor:
                            Theme.of(context).progressIndicatorTheme.color!,
                        textColor: Theme.of(context).highlightColor,
                        prefixIcon: Icon(Icons.account_circle_outlined),
                        margin: null,
                      ),
                      SizedBox(height: 8),
                      TextFieldWidget(
                        hint: "Пароль",
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        fieldAction: TextInputAction.done,
                        hasHideText: true,
                        fillColor: Theme.of(context).indicatorColor,
                        fieldBarColor:
                            Theme.of(context).progressIndicatorTheme.color!,
                        textColor: Theme.of(context).highlightColor,
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        margin: null,
                      ),
                      SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          launchURL("https://unmei.nix13.dev/restore");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Забыли пароль?",
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.lock_open,
                              size: 18,
                              color: Theme.of(context).highlightColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 36),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: accountButton(
                              onClick: () {
                                API().onLogin(
                                  login: loginController.text,
                                  pass: passwordController.text,
                                );
                              },
                              name: "Войти",
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: accountButton(
                              onClick: () {
                                launchURL("https://unmei.nix13.dev/");
                                FocusScope.of(context).unfocus();
                              },
                              name: "Зарегистрироваться",
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "или",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).highlightColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: accountButton(
                              onClick: () {
                                FocusScope.of(context).unfocus();
                                Navigator.of(context).pop();
                              },
                              name: "Продолжить без входа",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                  Column(
                    children: [
                      Text(
                        "Посетите нас на других платформах!",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          accSocialIcon(
                            label: "ВКонтакте",
                            url: "https://vk.com/unmei_site",
                            color: 0xFF597da3,
                            icon: "assets/icons/vk.svg",
                            edge: EdgeInsets.only(right: 8),
                          ),
                          accSocialIcon(
                            label: "Telegram",
                            url: "https://t.me/unmei_site",
                            icon: "assets/icons/telegram.svg",
                            edge: EdgeInsets.only(right: 8),
                            color: 0xFF0088cc,
                          ),
                          accSocialIcon(
                            label: "Discord",
                            url: "https://discord.gg/4CA8Cju",
                            icon: "assets/icons/discord.svg",
                            color: 0xFF7289DA,
                            edge: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget accountButton({VoidCallback? onClick, required String name}) {
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16)),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).highlightColor,
        ),
      ),
    );
  }

  Widget accSocialIcon({
    required String url,
    required String icon,
    required String label,
    required int color,
    required EdgeInsets edge,
  }) {
    return GestureDetector(
      onTap: () {
        launchURL(url);
      },
      child: Container(
        margin: edge,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon, height: 16),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
