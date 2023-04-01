import 'package:flutter/material.dart';
import 'package:mevn_app/app/utils/route/app_route.dart';

class AppMenu {
  static const appMainMenu = <Map<String, dynamic>>[
    {
      'title': 'KICKOFF',
      'route': AppRoute.routeKickoff,
      'icon': Icons.insert_chart,
    },
    {
      'title': 'ORDER BOOKS',
      'route': 'test',
      'icon': Icons.collections_bookmark_sharp,
    }
  ];

  static const appBarMainMenu = <Map<String, dynamic>>[
    {
      'title': 'NEWS',
      'route': 'test',
      'icon': Icons.newspaper_outlined,
    },
    {
      'title': 'ACCOUNT',
      'route': 'test',
      'icon': Icons.person,
    },
    {
      'title': 'RECRUITMENT',
      'route': 'test',
      'icon': Icons.app_registration,
    }
  ];
}
