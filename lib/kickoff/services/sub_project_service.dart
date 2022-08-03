import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';
import 'package:mevn_app/kickoff/models/sub_project_req.dart';
import 'package:mevn_app/kickoff/models/sub_project_res.dart';

class SubProjectService extends AppServiceProvider {
  final PrefProvider _prefProvider;
  SubProjectService(Dio _dio, this._prefProvider) : super(_dio);

  Future<List<String>?> getListSubPjIsCheck() async {
    return _prefProvider.subProjectSelection;
  }

  Future<SubProjectRes> getdata() async {
    final response = await dioHelper.get(route: '/config/new_sub_projects');
    return SubProjectRes.fromJson(response as Map<String, dynamic>);
  }

  Future<SubProjectReq> sendSelection(SubProjectReq param) async {
    final response = await dioHelper.post(
      route: '/sub_pj_selection',
      requestBody: param.toJson(),
    );
    await _prefProvider.setDataIsChecked(
      PrefNames.subProjectSelection,
      param.pjs,
    );
    final oldData = _prefProvider.menuIsSubmit;
    oldData!.removeAt(6);
    oldData.insert(6, 'true');
    await _prefProvider.setMenuIsSubmit(oldData);

    return SubProjectReq.fromJson(response as Map<String, dynamic>);
  }
}
