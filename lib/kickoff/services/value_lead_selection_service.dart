import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';
import 'package:mevn_app/kickoff/models/value_lead_selection.dart';

class ValueLeadSelectionService extends AppServiceProvider {
  final PrefProvider _prefProvider;
  ValueLeadSelectionService(Dio _dio, this._prefProvider) : super(_dio);

  Future<List<String>?> getListValueIsCheck() async {
    return _prefProvider.valueSelection;
  }

  Future<ValueLeadSelection> sendSelection(ValueLeadSelection param) async {
    final response = await dioHelper.post(
      route: '/value_lead_selection',
      requestBody: param.toJson(),
    );
    await _prefProvider.setDataIsChecked(PrefNames.valueSelection, param.pms);
    final oldData = _prefProvider.menuIsSubmit;
    oldData!.removeAt(4);
    oldData.insert(4, 'true');
    await _prefProvider.setMenuIsSubmit(oldData);
    return ValueLeadSelection.fromJson(response as Map<String, dynamic>);
  }
}
