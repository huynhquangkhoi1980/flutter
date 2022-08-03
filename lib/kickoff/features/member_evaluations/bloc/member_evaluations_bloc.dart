import 'package:bloc/bloc.dart';
import 'package:mevn_app/kickoff/features/member_evaluations/bloc/member_evaluations_state.dart';
import 'package:mevn_app/kickoff/models/member_evaluation_req.dart';
import 'package:mevn_app/kickoff/repositories/member_evaluation_repo.dart';
import 'package:mevn_app/kickoff/repositories/member_repo.dart';

class MemberEvaluationsBloc extends Cubit<MemberEvaluationsState> {
  final MemberEvaluationRepo memberEvaluationRepo;
  final MemberRepo memberRepo;
  MemberEvaluationsBloc(
    this.memberEvaluationRepo,
    this.memberRepo,
  ) : super(InMemberEvaluationsState());

  void getEvaluation() async {
    emit(LoadingState());
    final result = await memberEvaluationRepo.getEvaluation();
    result.fold(
      (memberEvaluationRes) => emit(
        MemberEvaluationState(memberEvaluationRes),
      ),
      (exception) => {
        emit(ErrorMemberEvaluationsState('System error, please try again!!!'))
      },
    );
  }

  void getMembers() async {
    emit(LoadingState());
    final checked = await memberEvaluationRepo.getListMemberIsCheck();
    emit(MemberIsCheckedState(checked));
    final members = await memberRepo.getdata();
    members.fold(
      (res) => emit(MembersLoadedState(res)),
      (exception) => emit(
        ErrorMemberEvaluationsState('System error, please try again!!!'),
      ),
    );
  }

  void sendEvaluation(MemberEvaluationReq param) async {
    emit(LoadingState());
    final res = await memberEvaluationRepo.sendEvaluation(param);
    res.fold(
      (memberEvaluationRes) => emit(SendEvaluationState(memberEvaluationRes)),
      (serverException) => {
        emit(ErrorMemberEvaluationsState('System error, please try again!!!'))
      },
    );
  }
}
