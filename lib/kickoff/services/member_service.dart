import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';
import 'package:mevn_app/kickoff/models/member_res.dart';

class MemberService extends AppServiceProvider {
  final PrefProvider _prefProvider;
  MemberService(Dio _dio, this._prefProvider) : super(_dio);

  Future<MemberRes> getdata() async {
    final response = await dioHelper.get(route: '/config/members');
    final newData = MemberRes.fromJson(response as Map<String, dynamic>);
    newData.members!
        .removeWhere((item) => item.email == _prefProvider.userEmail);
    return newData;
  }

  Future<int> getCountMember() async {
    return _prefProvider.countMember!;
  }
}
