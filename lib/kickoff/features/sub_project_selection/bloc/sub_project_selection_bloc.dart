import 'package:bloc/bloc.dart';
import 'package:mevn_app/kickoff/features/sub_project_selection/bloc/sub_project_selection_state.dart';
import 'package:mevn_app/kickoff/models/sub_project_req.dart';
import 'package:mevn_app/kickoff/repositories/sub_project_repo.dart';

class SubProjectBloc extends Cubit<SubProjectState> {
  final SubProjectRepo subProjectRepo;
  SubProjectBloc(this.subProjectRepo) : super(const InSubProjectState());

  void getList() async {
    emit(const LoadingState());
    final checked = await subProjectRepo.getListSubPjIsCheck();
    emit(SubPjIsCheckedState(checked));
    final result = await subProjectRepo.getdata();
    result.fold(
      (res) => emit(ProjectsLoadedState(res)),
      (exception) => emit(
        const ErrorSubProjectState('System error, please try again!!!'),
      ),
    );
  }

  void sendSelection(SubProjectReq param) async {
    emit(const LoadingState());
    final result = await subProjectRepo.sendSelection(param);
    result.fold(
      (res) => emit(SendSelectionState(res)),
      (exception) => emit(
        const ErrorSubProjectState('System error, please try again!!!'),
      ),
    );
  }
}
