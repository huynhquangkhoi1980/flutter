import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/news/models/home_res.dart';

class HomeService extends AppServiceProvider {
  HomeService(Dio _dio) : super(_dio);

  Future<HomeRes> getdata() async {
    final response = await dioHelper.get(
      route:
          '/wp-json/mevn/v1/posts?page=1&posts_per_page=10&select=ID,post_title,post_date,post_excerpt,guid',
    );

    return HomeRes.fromJson(response as List<dynamic>);
  }
}
