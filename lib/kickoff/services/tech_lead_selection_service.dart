import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';
import 'package:mevn_app/kickoff/models/tech_lead_selection.dart';

class TechLeadSelectionService extends AppServiceProvider {
  final PrefProvider _prefProvider;
  TechLeadSelectionService(Dio _dio, this._prefProvider) : super(_dio);

  Future<List<String>?> getListTechIsCheck() async {
    return _prefProvider.techSelection;
  }

  Future<TechLeadSelection> sendSelection(TechLeadSelection param) async {
    final response = await dioHelper.post(
      route: '/tech_lead_selection',
      requestBody: param.toJson(),
    );
    await _prefProvider.setDataIsChecked(PrefNames.techSelection, param.pms);
    final oldData = _prefProvider.menuIsSubmit;
    oldData!.removeAt(3);
    oldData.insert(3, 'true');
    await _prefProvider.setMenuIsSubmit(oldData);
    return TechLeadSelection.fromJson(response as Map<String, dynamic>);
  }
}
