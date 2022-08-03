import 'package:bloc/bloc.dart';
import 'package:mevn_app/book_order/features/book_register/bloc/book_register_state.dart';
import 'package:mevn_app/book_order/models/book.dart';
import 'package:mevn_app/book_order/repositories/book_register_repo.dart';

class BookRegisterBloc extends Cubit<BookRegisterState> {
  final BookRegisterRepo bookRegisterRepo;

  BookRegisterBloc(this.bookRegisterRepo) : super(InRegisterBookState());

  void sendRegisterBook(Book param) async {
    emit(LoadingState());
    final res = await bookRegisterRepo.sendEvaluation(param);
    res.fold(
      (memberEvaluationRes) => emit(SendRegisterBookState(param)),
      (serverException) => {
        emit(ErrorRegisterBookState('System error, please try again!!!'))
      },
    );
  }


}
