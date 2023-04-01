import 'package:bloc/bloc.dart';
import 'package:mevn_app/news/features/home/bloc/home_state.dart';
import 'package:mevn_app/news/models/post.dart';
import 'package:mevn_app/news/repositories/repo.dart';

class HomeBloc extends Cubit<HomeState> {
  final NewsRepo _newsRepo;
  HomeBloc(this._newsRepo) : super(InHomeState());

  Future<List<Post>?> getDataLoadMore(
    int _page,
    int _perPage,
    String _category,
  ) async {
    final res = await _newsRepo.getNews(_page, _perPage, _category);
    List<Post>? data;
    res.fold(
      (res) => data = res.posts,
      (exception) => emit(
        ErrorHomeState('Can not load data. Please try again!'),
      ),
    );
    return data;
  }
}
