import 'package:bloc/bloc.dart';
import 'package:mevn_app/kickoff/features/pm_selection/bloc/pm_selection_state.dart';
import 'package:mevn_app/kickoff/models/pm_selection.dart';
import 'package:mevn_app/kickoff/repositories/member_repo.dart';
import 'package:mevn_app/kickoff/repositories/pm_selection_repo.dart';
import 'package:mevn_app/kickoff/repositories/project_repo.dart';

class PmSelectionBloc extends Cubit<PmSelectionState> {
  final PmSelectionRepo pmSelectionRepo;
  final ProjectRepo projectRepo;
  final MemberRepo memberRepo;
  PmSelectionBloc(
    this.pmSelectionRepo,
    this.projectRepo,
    this.memberRepo,
  ) : super(const InPmSelectionState());

  void getListMember() async {
    emit(const LoadingState());
    final pMIsChecked = await pmSelectionRepo.getListPMIsCheck();
    emit(PMIsCheckedState(pMIsChecked));
    final countProject = await projectRepo.countProject();
    countProject.fold(
      (res) => emit(CountProductLoadedState(res)),
      (exception) => emit(CountProductLoadedState(0)),
    );
    final result = await memberRepo.getdata();
    result.fold(
      (res) => emit(MembersLoadedState(res)),
      (exception) => emit(
        const ErrorPmSelectionState('System error, please try again!!!'),
      ),
    );
  }

  void sendSelection(PmSelection param) async {
    emit(const LoadingState());
    final result = await pmSelectionRepo.sendSelection(param);
    result.fold(
      (res) => emit(SendSelectionState(res)),
      (exception) => emit(
        const ErrorPmSelectionState('System error, please try again!!!'),
      ),
    );
  }
}
