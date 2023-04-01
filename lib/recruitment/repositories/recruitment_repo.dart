import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/recruitment/models/recruitment_req.dart';
import 'package:mevn_app/recruitment/models/skill_res.dart';
import 'package:mevn_app/recruitment/services/recruitment.dart';

class RecruitmentRepo extends BaseRepository {
  final RecruitmentService recruitmentService;

  RecruitmentRepo({required this.recruitmentService});

  Future<Either<SkillRes, Exception>> getSkills() {
    return safeCall(recruitmentService.getSkills);
  }

  Future<Either<bool, Exception>> sendRecruitment(
    RecruitmentReq param,
  ) {
    return safeCall(() => recruitmentService.sendRecruitment(param));
  }
}
