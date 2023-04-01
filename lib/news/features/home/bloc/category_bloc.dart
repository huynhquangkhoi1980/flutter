import 'package:bloc/bloc.dart';
import 'package:mevn_app/news/features/home/bloc/category_state.dart';
import 'package:mevn_app/news/repositories/repo.dart';

class CategoryBloc extends Cubit<CategoryState> {
  final NewsRepo _newsRepo;
  CategoryBloc(this._newsRepo) : super(InCategoryState());

  void init() async {
    emit(LoadingState());
    final res = await _newsRepo.getCategories();
    res.fold(
      (res) => emit(CategoryLoadedState(res)),
      (exception) => emit(
        ErrorCategoryState('System error, please try again!!!'),
      ),
    );
  }
}
