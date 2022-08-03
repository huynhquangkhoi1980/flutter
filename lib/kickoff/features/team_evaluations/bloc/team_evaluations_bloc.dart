import 'package:bloc/bloc.dart';
import 'package:mevn_app/kickoff/features/team_evaluations/bloc/team_evaluations_state.dart';
import 'package:mevn_app/kickoff/models/team_evaluation_req.dart';
import 'package:mevn_app/kickoff/repositories/team_evaluation_repo.dart';
import 'package:mevn_app/kickoff/repositories/team_repo.dart';

class TeamEvaluationsBloc extends Cubit<TeamEvaluationsState> {
  final TeamEvaluationRepo teamEvaluationRepo;
  final TeamRepo teamRepo;

  TeamEvaluationsBloc(
    this.teamEvaluationRepo,
    this.teamRepo,
  ) : super(InTeamEvaluationsState());

  void getListProject() async {
    emit(LoadingState());
    final checked = await teamEvaluationRepo.getListProjectIsCheck();
    emit(TeamIsCheckedState(checked));
    final result = await teamRepo.getdata();
    result.fold(
      (res) => emit(TeamDataLoadedState(res)),
      (exception) => emit(
        ErrorTeamEvaluationsState('System error, please try again!!!'),
      ),
    );
  }

  void getEvaluation() async {
    emit(LoadingState());
    final result = await teamEvaluationRepo.getEvaluation();
    result.fold(
      (res) => emit(EvaluationLoadedState(res)),
      (exception) => emit(
        ErrorTeamEvaluationsState('System error, please try again!!!'),
      ),
    );
  }

  void sendEvaluation(TeamEvaluationReq param) async {
    emit(LoadingState());
    final result = await teamEvaluationRepo.sendEvaluation(param);
    result.fold(
      (res) {
        emit(SendEvaluationState(res));
      },
      (exception) => emit(
        ErrorTeamEvaluationsState('System error, please try again!!!'),
      ),
    );
  }
}
