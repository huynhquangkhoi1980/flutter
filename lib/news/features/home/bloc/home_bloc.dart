import 'package:bloc/bloc.dart';
import 'package:mevn_app/news/features/home/bloc/home_state.dart';
import 'package:mevn_app/news/repositories/home_repo.dart';

class HomeBloc extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeBloc(this._homeRepo) : super(InHomeState());

  void init() async {
    emit(LoadingState());
    final res = await _homeRepo.getdata();
    res.fold(
      (res) => emit(HomeLoadedState(res)),
      (exception) => emit(
        ErrorHomeState('System error, please try again!!!'),
      ),
    );
  }
}
