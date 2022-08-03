import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';

import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';

class BookListService extends AppServiceProvider {
  final PrefProvider _prefProvider;

  BookListService(Dio _dio, this._prefProvider) : super(_dio);
}
