// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/route/app_route.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';
import 'package:mevn_app/kickoff/models/menu_kickoff.dart';
import 'package:mevn_app/kickoff/models/menu_kickoff_req.dart';
import 'package:mevn_app/kickoff/services/member_service.dart';
import 'package:mevn_app/kickoff/services/team_service.dart';

class ActionSubmitService extends AppServiceProvider {
  ActionSubmitService(
    Dio _dio,
    this._prefProvider,
    this._memberService,
    this._teamService,
  ) : super(_dio);
  final PrefProvider _prefProvider;
  final MemberService _memberService;
  final TeamService _teamService;

  Future<bool> getIsSubmit(
    String actionName,
    String target,
    String object,
  ) async {
    final response = await dioHelper.post(
      route: '/check/is-submited',
      requestBody: {
        'action_name': actionName,
        'target': target,
        'object': object
      },
    );
    final data = response as Map<String, dynamic>;
    return data['status'] as bool;
  }

  Future<void> setCache() async {
    final getListSubmit =
        await dioHelper.post(route: '/check/list-of-submited', requestBody: {});
    const menus = [
      PrefNames.memberEvaluations,
      PrefNames.teamEvaluations,
      PrefNames.pMSelection,
      PrefNames.techSelection,
      PrefNames.valueSelection,
      PrefNames.projectSelection,
      PrefNames.subProjectSelection
    ];
    final menuIsSumitCache = <String>[];
    for (var i = 0; i < menus.length; i++) {
      if (menus[i] == PrefNames.memberEvaluations) {
        final data = getListSubmit[menus[i]] as List;
        final listMember = await _memberService.getdata();
        await _prefProvider.setCountData(
          PrefNames.countMember,
          listMember.members!.length,
        );
        if (data.isNotEmpty) {
          await _prefProvider.setDataIsChecked(
            menus[i],
            getListSubmit[menus[i]].cast<String>() as List<String>,
          );
          menuIsSumitCache.add(
            '${_prefProvider.memberEvaluations!.length >= _prefProvider.countMember!}',
          );
        } else {
          menuIsSumitCache.add('false');
        }
      } else if (menus[i] == PrefNames.teamEvaluations) {
        final data = getListSubmit[menus[i]] as List;
        final listTeam = await _teamService.getdata();
        await _prefProvider.setCountData(
          PrefNames.countTeam,
          listTeam.teams!.length,
        );
        if (data.isNotEmpty) {
          await _prefProvider.setDataIsChecked(
            menus[i],
            getListSubmit[menus[i]].cast<String>() as List<String>,
          );
          menuIsSumitCache.add(
            '${_prefProvider.teamEvaluations!.length >= _prefProvider.countTeam!}',
          );
        } else {
          menuIsSumitCache.add('false');
        }
      } else {
        final data = getListSubmit[menus[i]] as List;
        if (data.isNotEmpty) {
          menuIsSumitCache.add('${data[0]}');
        } else {
          menuIsSumitCache.add('false');
        }
      }
    }
    await _prefProvider.setMenuIsSubmit(menuIsSumitCache);
  }

  Future<List<String>?> getMenuIsSubmit() async {
    return _prefProvider.menuIsSubmit;
  }

  Future<MenuKickoffRes> getMenu() async {
    const menus = [
      {
        'name': 'Member Evaluations',
        'route': AppRoute.routeListMemberEvaluations,
        'isChecked': false,
      },
      {
        'name': 'Team Evaluations',
        'route': AppRoute.routeListTeamEvaluations,
        'isChecked': false,
        'ref': PrefNames.memberEvaluations
      },
      {
        'name': 'PM Selection',
        'route': AppRoute.routePmLeadSelection,
        'isChecked': false,
        'ref': PrefNames.pMSelection
      },
      {
        'name': 'Tech Lead Selection',
        'route': AppRoute.routeListTechLeadSelection,
        'isChecked': false,
        'ref': PrefNames.techSelection
      },
      {
        'name': 'Value Lead Selection',
        'route': AppRoute.routeListValueLeadSelection,
        'isChecked': false,
        'ref': PrefNames.valueSelection
      },
      {
        'name': 'Project Selection',
        'route': AppRoute.routeListProjectSelection,
        'isChecked': false,
        'ref': PrefNames.projectSelection
      },
      {
        'name': 'Sub-project Selection',
        'route': AppRoute.routeListSubProjectSelection,
        'isChecked': false,
        'ref': PrefNames.subProjectSelection
      }
    ];
    if (_prefProvider.menuIsSubmit == null) {
      await setCache();
    }
    final listMenu = <MenuKickoff>[];
    for (var i = 0; i < menus.length; i++) {
      final checked = _prefProvider.menuIsSubmit![i] == 'true' ? true : false;
      listMenu.add(
        MenuKickoff(
          name: menus[i]['name']! as String,
          route: menus[i]['route']! as String,
          isChecked: checked,
        ),
      );
    }

    final list = MenuKickoffRes(menuKickoff: listMenu);
    return list;
  }
}
