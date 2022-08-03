import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';
import 'package:mevn_app/kickoff/models/team_evaluation_req.dart';
import 'package:mevn_app/kickoff/models/team_evaluation_res.dart';

class TeamEvaluationService extends AppServiceProvider {
  final PrefProvider _prefProvider;
  TeamEvaluationService(Dio _dio, this._prefProvider) : super(_dio);

  Future<List<String>?> getListProjectIsCheck() async {
    return _prefProvider.teamEvaluations;
  }

  Future<TeamEvaluationRes> getEvaluation() async {
    final response = await dioHelper.get(route: '/config/team_evaluations');
    return TeamEvaluationRes.fromJson(response as Map<String, dynamic>);
  }

  Future<TeamEvaluationReq> sendEvaluation(TeamEvaluationReq param) async {
    final response = await dioHelper.post(
      route: '/team_evaluation',
      requestBody: param.toJson(),
    );
    var newData = <String>[];
    if (_prefProvider.teamEvaluations != null) {
      newData = _prefProvider.teamEvaluations!;
    }
    newData.add(param.name!);
    await _prefProvider.setDataIsChecked(PrefNames.teamEvaluations, newData);
    if (newData.length >= _prefProvider.countTeam!) {
      final oldData = _prefProvider.menuIsSubmit;
      oldData!.removeAt(1);
      oldData.insert(1, 'true');
      await _prefProvider.setMenuIsSubmit(oldData);
    }
    return TeamEvaluationReq.fromJson(response as Map<String, dynamic>);
  }
}
