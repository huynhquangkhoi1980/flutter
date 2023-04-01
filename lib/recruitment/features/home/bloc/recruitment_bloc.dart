import 'package:bloc/bloc.dart';
import 'package:mevn_app/recruitment/features/home/bloc/recruitment_state.dart';
import 'package:mevn_app/recruitment/models/recruitment_req.dart';
import 'package:mevn_app/recruitment/models/skill.dart';
import 'package:mevn_app/recruitment/repositories/recruitment_repo.dart';

class RecruitmentBloc extends Cubit<RecruitmentState> {
  final RecruitmentRepo _recruitmentRepo;
  RecruitmentBloc(this._recruitmentRepo) : super(InRecruitmentState());

  Future<List<Skill>?> getSkills() async {
    final res = await _recruitmentRepo.getSkills();
    List<Skill>? data;
    res.fold(
      (res) => data = res.skills,
      (exception) => emit(
        ErrorRecruitmentState('System error, please try again!!!'),
      ),
    );
    return data;
  }

  Future<bool?> sendRecruitment(RecruitmentReq param) async {
    final res = await _recruitmentRepo.sendRecruitment(param);
    bool? isDone;
    res.fold(
      (memberEvaluationRes) => {isDone = memberEvaluationRes},
      (serverException) =>
          {emit(ErrorRecruitmentState('System error, please try again!!!'))},
    );

    return isDone;
  }
}
