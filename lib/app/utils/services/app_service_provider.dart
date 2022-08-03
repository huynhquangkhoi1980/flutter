import 'package:dio/dio.dart';
import '../networks/core/dio_helper.dart';
import '../networks/core/handler/app_response_handler.dart';

class AppServiceProvider {
  late DioHelper dioHelper;

  AppServiceProvider(Dio _dio) {
    dioHelper = DioHelper(_dio, responseHandler: AppResponseHandler());
  }
}
