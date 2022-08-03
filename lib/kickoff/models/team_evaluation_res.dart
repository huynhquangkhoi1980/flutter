import 'package:mevn_app/kickoff/models/team_evalution.dart';

class TeamEvaluationRes {
  List<TeamEvaluation>? evaluations;

  TeamEvaluationRes({this.evaluations});

  TeamEvaluationRes.fromJson(Map<String, dynamic> json) {
    if (json['evaluations'] != null) {
      evaluations = <TeamEvaluation>[];
      json['evaluations'].forEach((v) {
        evaluations!.add(TeamEvaluation.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (evaluations != null) {
      data['evaluations'] = evaluations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
