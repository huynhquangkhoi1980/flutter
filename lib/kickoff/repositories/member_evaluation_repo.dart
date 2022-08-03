import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/kickoff/models/member_evaluation_req.dart';
import 'package:mevn_app/kickoff/models/member_evaluation_res.dart';
import 'package:mevn_app/kickoff/services/member_evaluation_service.dart';

class MemberEvaluationRepo extends BaseRepository {
  final MemberEvaluationService memberEvaluationService;

  MemberEvaluationRepo({required this.memberEvaluationService});

  Future<List<String>?> getListMemberIsCheck() {
    return memberEvaluationService.getListMemberIsCheck();
  }

  Future<Either<MemberEvaluationRes, Exception>> getEvaluation() {
    return safeCall(memberEvaluationService.getEvaluation);
  }

  Future<Either<MemberEvaluationReq, Exception>> sendEvaluation(
    MemberEvaluationReq param,
  ) {
    return safeCall(() => memberEvaluationService.sendEvaluation(param));
  }
}
