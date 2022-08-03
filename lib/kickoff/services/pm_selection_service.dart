import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';
import 'package:mevn_app/kickoff/models/pm_selection.dart';

class PmSelectionService extends AppServiceProvider {
  final PrefProvider _prefProvider;
  PmSelectionService(Dio _dio, this._prefProvider) : super(_dio);

  Future<List<String>?> getListPMIsCheck() async {
    return _prefProvider.pMSelection;
  }

  Future<PmSelection> sendSelection(PmSelection param) async {
    final response = await dioHelper.post(
      route: '/pm_selection',
      requestBody: param.toJson(),
    );
    await _prefProvider.setDataIsChecked(PrefNames.pMSelection, param.pms);
    final oldData = _prefProvider.menuIsSubmit;
    oldData!.removeAt(2);
    oldData.insert(2, 'true');
    await _prefProvider.setMenuIsSubmit(oldData);

    return PmSelection.fromJson(response as Map<String, dynamic>);
  }
}
