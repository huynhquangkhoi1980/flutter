import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/recruitment/models/recruitment_req.dart';
import 'package:mevn_app/recruitment/models/skill_res.dart';

class RecruitmentService extends AppServiceProvider {
  RecruitmentService(Dio _dio) : super(_dio);

  Future<SkillRes> getSkills() async {
    final response = await dioHelper.get(
      route: '/skills?_sort=sort_order:ASC',
    );
    return SkillRes.fromJson(response as List<dynamic>);
  }

  Future<bool> sendRecruitment(RecruitmentReq param) async {
    var res = false;
    await dioHelper
        .post(
      route: '/subscribers',
      requestBody: param.toJson(),
    )
        .whenComplete(() {
      res = true;
    });
    return res;
  }
}
