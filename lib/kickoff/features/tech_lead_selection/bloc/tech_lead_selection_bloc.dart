import 'package:bloc/bloc.dart';
import 'package:mevn_app/kickoff/features/tech_lead_selection/bloc/tech_lead_selection_state.dart';
import 'package:mevn_app/kickoff/models/tech_lead_selection.dart';
import 'package:mevn_app/kickoff/repositories/member_repo.dart';
import 'package:mevn_app/kickoff/repositories/project_repo.dart';
import 'package:mevn_app/kickoff/repositories/tech_lead_selection_repo.dart';

class TechLeadSelectionBloc extends Cubit<TechLeadSelectionState> {
  final TechLeadSelectionRepo techLeadSelectionRepo;
  final MemberRepo memberRepo;
  final ProjectRepo projectRepo;
  TechLeadSelectionBloc(
    this.techLeadSelectionRepo,
    this.memberRepo,
    this.projectRepo,
  ) : super(const InTechLeadSelectionState());

  void getListMember() async {
    emit(const LoadingState());
    final checked = await techLeadSelectionRepo.getListTechIsCheck();
    emit(TechIsCheckedState(checked));
    final countProject = await projectRepo.countProject();
    countProject.fold(
      (count) => emit(CountProductLoadedState(count)),
      (exception) => emit(CountProductLoadedState(0)),
    );
    final result = await memberRepo.getdata();
    result.fold(
      (memberRes) => emit(MembersLoadedState(memberRes)),
      (exception) => emit(
        const ErrorTechLeadSelectionState('System error, please try again!!!'),
      ),
    );
  }

  void sendSelection(TechLeadSelection param) async {
    emit(const LoadingState());
    final result = await techLeadSelectionRepo.sendSelection(param);
    result.fold(
      (techLeadSelection) => emit(SendSelectionState(techLeadSelection)),
      (exception) => emit(
        const ErrorTechLeadSelectionState('System error, please try again!!!'),
      ),
    );
  }
}
