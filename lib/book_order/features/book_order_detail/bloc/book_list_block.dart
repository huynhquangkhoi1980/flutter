import 'package:bloc/bloc.dart';
import 'package:mevn_app/book_order/features/book_order_detail/bloc/book_list_state.dart';
import 'package:mevn_app/book_order/models/book.dart';
import 'package:mevn_app/book_order/repositories/book_list_repo.dart';

class BookListBloc extends Cubit<BookListState> {
  final BookListRepo bookListRepo;
  final List<Book> DUMMY_DATA = [
    Book(
      title: 'Title 1',
      link: 'Link 1',
      purpose: 'Purpose 1',
      kind: 'Human Skill',
      approved: 'Approve Not Yet',
      comment: '',
      commentCorporate: '',
    ),
    Book(
      title: 'Title 2',
      link: 'Link 2',
      purpose: 'Purpose 2',
      kind: 'Organization',
      approved: 'Approve Not Yet',
      comment: '',
      commentCorporate: '',
    ),
    Book(
      title: 'Title 3',
      link: 'Link 3',
      purpose: 'Purpose 3',
      kind: 'Programming',
      approved: 'Approve Not Yet',
      comment: '',
      commentCorporate: '',
    ),
    Book(
      title: 'Title 4',
      link: 'Link 4',
      purpose: 'Purpose 4',
      kind: 'Comic',
      approved: 'Approve Not Yet',
      comment: '',
      commentCorporate: '',
    ),
    Book(
      title: 'Title 5',
      link: 'Link 5',
      purpose: 'Purpose 5',
      kind: 'Language',
      approved: 'Approve Not Yet',
      comment: '',
      commentCorporate: '',
    ),
    Book(
      title: 'Title 6',
      link: 'Link 6',
      purpose: 'Purpose 6',
      kind: 'Human Skill',
      approved: 'Approved',
      comment: 'Comment for testing 1',
      commentCorporate: '',
    ),
    Book(
      title: 'Title 7',
      link: 'Link 7',
      purpose: 'Purpose 7',
      kind: 'Comic',
      approved: 'Approved',
      comment: 'Comment for testing 2',
      commentCorporate: '',
    ),
  ];

  BookListBloc(this.bookListRepo) : super(InBookListState());

  void searchBook(String title, String category, String approved) {
    emit(LoadingBookListState());
    //call api -> repo -> searvice

    print(category);
    print(approved);

    List<Book> data = DUMMY_DATA;
    // if (title != '')
    data = DUMMY_DATA
        .where((map) =>
            map.title?.indexOf(title) != -1 &&
            map.kind == category &&
            map.approved == approved)
        .toList();

    emit(SearchBookListState(data));
  }
}
