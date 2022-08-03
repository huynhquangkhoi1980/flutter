import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';
import 'package:mevn_app/kickoff/models/project_req.dart';
import 'package:mevn_app/kickoff/models/project_res.dart';

class ProjectService extends AppServiceProvider {
  final PrefProvider _prefProvider;
  ProjectService(Dio _dio, this._prefProvider) : super(_dio);

  Future<List<String>?> getListPjIsCheck() async {
    return _prefProvider.projectSelection;
  }

  Future<ProjectRes> getdata() async {
    final response = await dioHelper.get(route: '/config/new_projects');
    return ProjectRes.fromJson(response as Map<String, dynamic>);
  }

  Future<int> countProject() async {
    final response = await dioHelper.get(route: '/config/new_projects');
    final newresponse = ProjectRes.fromJson(response as Map<String, dynamic>);
    newresponse.projects!.length;
    return newresponse.projects!.length;
  }

  Future<ProjectReq> sendSelection(ProjectReq param) async {
    final response = await dioHelper.post(
      route: '/pj_selection',
      requestBody: param.toJson(),
    );
    await _prefProvider.setDataIsChecked(PrefNames.projectSelection, param.pjs);
    final oldData = _prefProvider.menuIsSubmit;
    oldData!.removeAt(5);
    oldData.insert(5, 'true');
    await _prefProvider.setMenuIsSubmit(oldData);
    return ProjectReq.fromJson(response as Map<String, dynamic>);
  }
}
