import 'package:bloc/bloc.dart';
import 'package:mevn_app/kickoff/features/project_selection/bloc/project_selection_state.dart';
import 'package:mevn_app/kickoff/models/project_req.dart';
import 'package:mevn_app/kickoff/repositories/project_repo.dart';

class ProjectBloc extends Cubit<ProjectState> {
  final ProjectRepo projectRepo;
  ProjectBloc(this.projectRepo) : super(const InProjectState());

  void getList() async {
    emit(const LoadingState());
    final checked = await projectRepo.getListPjIsCheck();
    emit(PjIsCheckedState(checked));
    final result = await projectRepo.getdata();
    result.fold(
      (res) => emit(ProjectsLoadedState(res)),
      (exception) => emit(
        const ErrorProjectState('System error, please try again!!!'),
      ),
    );
  }

  void sendSelection(ProjectReq param) async {
    emit(const LoadingState());
    final result = await projectRepo.sendSelection(param);
    result.fold(
      (res) => emit(SendSelectionState(res)),
      (exception) => emit(
        const ErrorProjectState('System error, please try again!!!'),
      ),
    );
  }
}
