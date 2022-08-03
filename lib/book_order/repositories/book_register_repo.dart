import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/book_order/models/book.dart';
import 'package:mevn_app/book_order/services/book_register_service.dart';

import 'package:mevn_app/book_order/services/book_register_service.dart';

class BookRegisterRepo extends BaseRepository {
  final BookRegisterService bookRegisterService;

  BookRegisterRepo({required this.bookRegisterService});

  Future<Either<bool, Exception>> sendEvaluation(Book param,) {
    return safeCall(() => bookRegisterService.registerBook(param));
  }
}
