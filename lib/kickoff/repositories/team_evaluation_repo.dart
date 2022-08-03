import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/kickoff/models/team_evaluation_req.dart';
import 'package:mevn_app/kickoff/models/team_evaluation_res.dart';
import 'package:mevn_app/kickoff/services/team_evaluation_service.dart';

class TeamEvaluationRepo extends BaseRepository {
  final TeamEvaluationService teamEvaluationService;

  TeamEvaluationRepo({required this.teamEvaluationService});

  Future<List<String>?> getListProjectIsCheck() {
    return teamEvaluationService.getListProjectIsCheck();
  }

  Future<Either<TeamEvaluationRes, Exception>> getEvaluation() {
    return safeCall(teamEvaluationService.getEvaluation);
  }

  Future<Either<TeamEvaluationReq, Exception>> sendEvaluation(
    TeamEvaluationReq param,
  ) {
    return safeCall(() => teamEvaluationService.sendEvaluation(param));
  }
}
