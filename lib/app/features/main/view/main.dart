import 'package:flutter/material.dart';
import 'package:mevn_app/app/features/auth/view/account.dart';
import 'package:mevn_app/app/widget/app_bar_widget.dart';
import 'package:mevn_app/app/widget/body_widget.dart';
import 'package:mevn_app/app/widget/bottom_navigation_widget.dart';
import 'package:mevn_app/app/widget/drawer_menu_widget.dart';
import 'package:mevn_app/news/features/home/view/index.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ListNewsScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      drawer: const DrawerMenuWidget(),
      body: BodyWidget(
        child: _widgetOptions.elementAt(currentIndex),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        onTap: (value) {
          setState(
            () => currentIndex = value,
          );
        },
      ),
    );
  }
}
