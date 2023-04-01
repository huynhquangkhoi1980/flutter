import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/news/models/category_res.dart';
import 'package:mevn_app/news/models/home_res.dart';
import 'package:mevn_app/news/services/service.dart';

class NewsRepo extends BaseRepository {
  final NewsService newsService;

  NewsRepo({required this.newsService});

  Future<Either<HomeRes, Exception>> getNews(
    int _page,
    int _perPage,
    String _category,
  ) {
    return safeCall(() => newsService.getNews(_page, _perPage, _category));
  }

  Future<Either<CategoryRes, Exception>> getCategories() {
    return safeCall(newsService.getCategories);
  }
}
