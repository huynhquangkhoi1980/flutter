import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/news/models/home_res.dart';
import 'package:mevn_app/news/services/home_service.dart';

class HomeRepo extends BaseRepository {
  final HomeService homeService;

  HomeRepo({required this.homeService});

  Future<Either<HomeRes, Exception>> getdata() {
    return safeCall(homeService.getdata);
  }
}
