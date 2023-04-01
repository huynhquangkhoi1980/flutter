// ignore_for_file: require_trailing_commas

import 'package:flutter/material.dart';
import 'package:mevn_app/app/features/auth/view/home.dart';
import 'package:mevn_app/app/features/main/view/main.dart';
import 'package:mevn_app/book_order/features/book_order_approve/view/approve.dart';
import 'package:mevn_app/book_order/features/book_order_detail/view/list.dart';
import 'package:mevn_app/book_order/features/book_register/view/register.dart';
import 'package:mevn_app/kickoff/features/member_evaluations/view/detail.dart';
import 'package:mevn_app/kickoff/features/member_evaluations/view/list.dart';
import 'package:mevn_app/kickoff/features/pm_selection/view/list.dart';
import 'package:mevn_app/kickoff/features/project_selection/view/list.dart';
import 'package:mevn_app/kickoff/features/sub_project_selection/view/list.dart';
import 'package:mevn_app/kickoff/features/team_evaluations/view/detail.dart';
import 'package:mevn_app/kickoff/features/team_evaluations/view/list.dart';
import 'package:mevn_app/kickoff/features/tech_lead_selection/view/list.dart';
import 'package:mevn_app/kickoff/features/value_lead_selection/view/list.dart';
import 'package:mevn_app/kickoff/view/kickoff_main.dart';
import 'package:mevn_app/news/features/home/view/index.dart';
import 'package:page_transition/page_transition.dart';

import '../../../book_order/view/bookorder_main.dart';

class AppRoute {
  factory AppRoute() => _instance;

  AppRoute._private();

  ///#region ROUTE NAMES
  /// -----------------
  static const String routeRoot = '/';
  static const String routeHome = '/home';
  static const String routeKickoff = '/kickoff';
  static const String routeListMemberEvaluations = '/list-member-evaluations';
  static const String routeDetailMemberEvaluations =
      '/detail-member-evaluations';
  static const String routeDetailTeamEvaluations = '/detail-team-evaluations';
  static const String routeListTeamEvaluations = '/list-team-evaluations';
  static const String routeListValueLeadSelection =
      '/list-value-lead-selection';
  static const String routePmLeadSelection = '/list-pm-selection';
  static const String routeListTechLeadSelection = '/list-tech-lead-selection';
  static const String routeListSubProjectSelection =
      '/list-sub-project-selection';
  static const String routeListProjectSelection = '/list-project-selection';
  static const String routeListNews = '/list-news';

  // Book order feature
  static const String routeBookOrder = '/book-order';

  static const String routeBookOrderRegister = '/book-order-register';

  static const String routeBookOrderList = '/book-order-list';

  static const String routeBookOrderApprove = 'book-order-approve';

  ///#endregion

  static final AppRoute _instance = AppRoute._private();

  static AppRoute get I => _instance;

  /// App route observer
  final RouteObserver<Route<dynamic>> routeObserver =
      RouteObserver<Route<dynamic>>();

  /// App global navigator key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Get app context
  BuildContext? get appContext => navigatorKey.currentContext;

  /// Generate route for app here
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeRoot:
        return _pageRoute(settings, const MainScreen());
      case routeHome:
        return _pageRoute(settings, const HomeScreen());
      case routeKickoff:
        return _pageRoute(settings, const KickoffScreen());
      case routeListMemberEvaluations:
        return _pageRoute(settings, const ListMemberEvaluationsScreen());
      case routeDetailMemberEvaluations:
        return _pageRoute(settings, const DetailMemberEvaluationsScreen());
      case routeListTeamEvaluations:
        return _pageRoute(settings, const ListTeamEvaluationsScreen());
      case routeDetailTeamEvaluations:
        return _pageRoute(settings, const DetailTeamEvaluationsScreen());
      case routeListValueLeadSelection:
        return _pageRoute(settings, const ListValueLeadSelectionScreen());
      case routeListTechLeadSelection:
        return _pageRoute(settings, const ListTechLeadSelectionScreen());
      case routePmLeadSelection:
        return _pageRoute(settings, const PmLeadSelectionScreen());
      case routeListSubProjectSelection:
        return _pageRoute(settings, const ListSubProjectScreen());
      case routeListProjectSelection:
        return _pageRoute(settings, const ListProjectScreen());

      // Book order feature
      case routeBookOrder:
        return _pageRoute(settings, const BookOrderScreen());
      case routeBookOrderRegister:
        return _pageRoute(
            settings,
            BookOrderRegisterScreen(
              arguments: settings.arguments,
            ));
      case routeBookOrderList:
        return _pageRoute(settings, const BookOrderListScreen());

      case routeBookOrderApprove:
        return _pageRoute(
            settings,
            BookOrderApproveScreen(
              arguments: settings.arguments,
            ));

      case routeListNews:
        return _pageRoute(settings, const ListNewsScreen());
      default:
        return null;
    }
  }

  static PageTransition<dynamic> _pageRoute(RouteSettings setting, Widget page,
          {PageTransitionType? transition}) =>
      PageTransition<dynamic>(
        child: page,
        type: transition ?? PageTransitionType.rightToLeftWithFade,
        settings:
            RouteSettings(name: setting.name, arguments: setting.arguments),
      );
}
