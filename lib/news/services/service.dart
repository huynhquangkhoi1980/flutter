import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/news/models/category_res.dart';
import 'package:mevn_app/news/models/home_res.dart';

class NewsService extends AppServiceProvider {
  NewsService(Dio _dio) : super(_dio);

  Future<HomeRes> getNews(
    int _page,
    int _perPage,
    String category,
  ) async {
    final query = category != 'all' ? '&category=$category' : '';
    final response = await dioHelper.get(
      route:
          '/wp-json/mevn/v1/posts?page=$_page&posts_per_page=$_perPage$query&select=ID,post_title,post_date,post_excerpt,guid,thumbnail,post_content,post_author,post_author_name',
    );

    return HomeRes.fromJson(response as List<dynamic>);
  }

  Future<CategoryRes> getCategories() async {
    final response = await dioHelper.get(
      route: '/wp-json/mevn/v1/post-categories',
    );

    return CategoryRes.fromJson(response as List<dynamic>);
  }
}
