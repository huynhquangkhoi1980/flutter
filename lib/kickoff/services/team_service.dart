import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';
import 'package:mevn_app/kickoff/models/team.dart';
import 'package:mevn_app/kickoff/models/team_res.dart';

class TeamService extends AppServiceProvider {
  final PrefProvider _prefProvider;
  TeamService(Dio _dio, this._prefProvider) : super(_dio);

  Future<TeamsRes> getdata() async {
    final response = await dioHelper.get(route: '/config/teams');
    final excludeData = TeamsRes.fromJson(response as Map<String, dynamic>);
    excludeData.teams!.removeWhere((team) {
      final index = team.members!
          .indexWhere((member) => member == _prefProvider.userEmail);
      return index > -1;
    });
    return excludeData;
  }

  Future<int> getCountTeam() async {
    final response = await dioHelper.get(route: '/config/teams');
    final newData = Team.fromJson(response as Map<String, dynamic>);
    final countData = newData.members!.length;
    await _prefProvider.setCountData(PrefNames.countMember, countData);
    return _prefProvider.countTeam != null ? _prefProvider.countTeam! : 0;
  }
}
