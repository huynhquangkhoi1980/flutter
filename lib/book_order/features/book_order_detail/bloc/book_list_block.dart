import 'package:bloc/bloc.dart';
import 'package:mevn_app/book_order/features/book_order_detail/bloc/book_list_state.dart';
import 'package:mevn_app/book_order/repositories/book_list_repo.dart';

class BookListBloc extends Cubit<BookListState> {
  final BookListRepo bookListRepo;

  BookListBloc(this.bookListRepo) : super();
}