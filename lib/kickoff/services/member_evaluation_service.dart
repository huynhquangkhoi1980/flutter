import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';
import 'package:mevn_app/kickoff/models/member_evaluation_req.dart';
import 'package:mevn_app/kickoff/models/member_evaluation_res.dart';

class MemberEvaluationService extends AppServiceProvider {
  final PrefProvider _prefProvider;
  MemberEvaluationService(Dio _dio, this._prefProvider) : super(_dio);

  Future<List<String>?> getListMemberIsCheck() async {
    return _prefProvider.memberEvaluations;
  }

  Future<MemberEvaluationRes> getEvaluation() async {
    final response = await dioHelper.get(route: '/config/member_evaluations');
    return MemberEvaluationRes.fromJson(response as Map<String, dynamic>);
  }

  Future<MemberEvaluationReq> sendEvaluation(MemberEvaluationReq param) async {
    final response = await dioHelper.post(
      route: '/member_evaluation',
      requestBody: param.toJson(),
    );
    var newData = <String>[];
    if (_prefProvider.memberEvaluations != null) {
      newData = _prefProvider.memberEvaluations!;
    }
    newData.add(param.email!);
    await _prefProvider.setDataIsChecked(PrefNames.memberEvaluations, newData);
    if (newData.length >= _prefProvider.countMember!) {
      final oldData = _prefProvider.menuIsSubmit;
      oldData!.removeAt(0);
      oldData.insert(0, 'true');
      await _prefProvider.setMenuIsSubmit(oldData);
    }
    return MemberEvaluationReq.fromJson(response as Map<String, dynamic>);
  }
}
