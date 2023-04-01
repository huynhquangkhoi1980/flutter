import 'package:bloc/bloc.dart';
import 'package:mevn_app/book_order/models/book.dart';

import '../../../repositories/book_approve_repo.dart';
import 'book_approve_state.dart';

class BookApproveBloc extends Cubit<BookApproveState> {
  final BookApproveRepo bookApproveRepo;

  BookApproveBloc(this.bookApproveRepo) : super(InApproveBookState());

  void sendApproveBook(Book param) async {
    emit(LoadingApproveState());
    final res = await bookApproveRepo.sendEvaluation(param);
    res.fold(
      (memberEvaluationRes) => emit(SendApproveBookState(param)),
      (serverException) =>
          {emit(ErrorApproveBookState('System error, please try again!!!'))},
    );
  }
}
