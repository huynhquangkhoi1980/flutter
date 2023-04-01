import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/book_order/services/book_register_service.dart';

import 'package:mevn_app/book_order/services/book_list_service.dart';

class BookListRepo extends BaseRepository {
  final BookListService bookListService;

  BookListRepo({required this.bookListService});
}
