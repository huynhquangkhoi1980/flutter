import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/book_order/models/book.dart';

import '../services/book_approve_service.dart';

class BookApproveRepo extends BaseRepository {
  final BookApproveService bookApproveService;

  BookApproveRepo({required this.bookApproveService});

  Future<Either<bool, Exception>> sendEvaluation(
    Book param,
  ) {
    return safeCall(() => bookApproveService.approveBook(param));
  }
}
