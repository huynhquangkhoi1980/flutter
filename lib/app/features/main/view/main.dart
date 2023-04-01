import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mevn_app/app/features/auth/view/account.dart';
import 'package:mevn_app/app/utils/constants/app_colors.dart';
import 'package:mevn_app/app/utils/constants/app_menu.dart';
import 'package:mevn_app/app/widget/app_bar_widget.dart';
import 'package:mevn_app/app/widget/body_widget.dart';
import 'package:mevn_app/app/widget/bottom_navigation_widget.dart';
import 'package:mevn_app/app/widget/drawer_menu_widget.dart';
import 'package:mevn_app/news/features/home/view/index.dart';
import 'package:mevn_app/recruitment/features/home/view/index.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  late bool _showAppbar = true;
  late ScrollController _scrollViewController;
  late bool isScrollingDown = false;
  late String _categoryId;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _categoryId = 'all';
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  void onTap(int value) {
    setState(() {
      _currentIndex = value;
      _showAppbar = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _widgetOptions = <Widget>[
      ListNewsScreen(
        category: _categoryId,
        scrollViewController: _scrollViewController,
      ),
      const AccountScreen(),
      RecruitmentFormScreen(
        changeScreen: onTap,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.orangeMainColor,
      body: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.appBarMainColor,
          appBar: AppBarWidget(showAppbar: _showAppbar),
          drawer: DrawerMenuWidget(
            onTap: (value) {
              setState(
                () {
                  _categoryId = value;
                  _currentIndex = 0;
                },
              );
            },
          ),
          body: SafeArea(
            bottom: false,
            child: BodyWidget(
              child: _widgetOptions.elementAt(_currentIndex),
            ),
          ),
          bottomNavigationBar: AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 500),
            height: _showAppbar ? 84 : 50,
            child: _showAppbar
                ? Wrap(
                    children: <Widget>[
                      BottomNavigationBar(
                        iconSize: _showAppbar ? 24.0 : 0.0,
                        elevation: 1,
                        type: BottomNavigationBarType.fixed,
                        currentIndex: _currentIndex,
                        backgroundColor: AppColors.orangeMainColor,
                        selectedItemColor: AppColors.bodyMainColor,
                        unselectedItemColor:
                            const Color.fromARGB(123, 255, 255, 255),
                        selectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        onTap: onTap,
                        items: [
                          for (var index = 0;
                              index < AppMenu.appBarMainMenu.length;
                              ++index)
                            BottomNavigationBarItem(
                              label: AppMenu.appBarMainMenu[index]['title']
                                  as String,
                              icon: Icon(
                                AppMenu.appBarMainMenu[index]['icon']
                                    as IconData,
                              ),
                            ),
                        ],
                      ),
                    ],
                  )
                : Container(
                    color: AppColors.orangeMainColor,
                    height: 30,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 12),
                    child: IconTextButton(
                      labelStyle: const TextStyle(color: Colors.white),
                      icon: Icon(
                        AppMenu.appBarMainMenu[_currentIndex]['icon']
                            as IconData,
                        size: 14,
                        color: Colors.white,
                      ),
                      label: AppMenu.appBarMainMenu[_currentIndex]['title']
                          as String,
                      onTap: () {},
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    super.dispose();
  }
}
