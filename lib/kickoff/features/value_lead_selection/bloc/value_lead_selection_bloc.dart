import 'package:bloc/bloc.dart';
import 'package:mevn_app/kickoff/features/value_lead_selection/bloc/value_lead_selection_state.dart';
import 'package:mevn_app/kickoff/models/value_lead_selection.dart';
import 'package:mevn_app/kickoff/repositories/member_repo.dart';
import 'package:mevn_app/kickoff/repositories/project_repo.dart';
import 'package:mevn_app/kickoff/repositories/value_lead_selection_repo.dart';

class ValueLeadSelectionBloc extends Cubit<ValueLeadSelectionState> {
  final ValueLeadSelectionRepo valueLeadSelectionRepo;
  final MemberRepo memberRepo;
  final ProjectRepo projectRepo;
  ValueLeadSelectionBloc(
    this.valueLeadSelectionRepo,
    this.memberRepo,
    this.projectRepo,
  ) : super(const InValueLeadSelectionState());

  void getListMember() async {
    emit(const LoadingState());
    final checked = await valueLeadSelectionRepo.getListValueIsCheck();
    emit(ValueIsCheckedState(checked));
    final countProject = await projectRepo.countProject();
    countProject.fold(
      (count) => emit(CountProductLoadedState(count)),
      (exception) => emit(CountProductLoadedState(0)),
    );
    final result = await memberRepo.getdata();
    result.fold(
      (memberRes) => emit(MembersLoadedState(memberRes)),
      (exception) => emit(
        const ErrorValueLeadSelectionState('System error, please try again!!!'),
      ),
    );
  }

  void sendSelection(ValueLeadSelection param) async {
    emit(const LoadingState());
    final res = await valueLeadSelectionRepo.sendSelection(param);
    res.fold(
      (valueLeadSelection) => emit(SendSelectionState(valueLeadSelection)),
      (exception) => emit(
        const ErrorValueLeadSelectionState('System error, please try again!!!'),
      ),
    );
  }
}
