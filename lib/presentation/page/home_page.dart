import 'package:flutter/material.dart';

import 'package:unmei/presentation/page/news_page.dart';
import 'package:unmei/presentation/page/novel_page.dart';
import 'package:unmei/presentation/page/settings_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: _navBarsItems(),
          selectedItemColor: _tabColor(_selectedIndex),
          backgroundColor: Theme.of(context).bottomAppBarColor,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: _buildScreens().elementAt(_selectedIndex),
    );
  }

  Color _tabColor(int index) {
    switch (index) {
      case 0: return Color(0xFF7AB9FF);
      case 1: return Color(0xFFE864FB);
      case 2: return Color(0xFFFB6464);
      default: return Colors.white;
    }
  }

  String selectedItemParams({String choose = "name"}) {
    String name = "";
    switch (_selectedIndex) {
      case 0: name = choose == "color" ? "0xFF7AB9FF" : "Новости";
        break;
      case 1: name = choose == "color" ? "0xFFE864FB" : "Новеллы";
        break;
      case 2: name = choose == "color" ? "0xFFFB6464" : "Настройки";
        break;
    }
    return name;
  }

  List<Widget> _buildScreens() {
    return [
      NewsPage(),
      NovelsPage(),
      SettingsPage(),
    ];
  }

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: ("Главная"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.my_library_books),
        label: ("Новеллы"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.manage_accounts),
        label: ("Настройки"),
      ),
    ];
  }
}
