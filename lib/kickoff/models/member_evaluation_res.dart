import 'package:mevn_app/kickoff/models/member_evalution.dart';
import 'package:mevn_app/kickoff/models/member_feedback.dart';

class MemberEvaluationRes {
  List<MemberEvaluation>? evaluations;
  List<MemberFeedback>? feedbacks;

  MemberEvaluationRes({this.evaluations, this.feedbacks});

  MemberEvaluationRes.fromJson(Map<String, dynamic> json) {
    if (json['evaluations'] != null) {
      evaluations = <MemberEvaluation>[];
      json['evaluations'].forEach((v) {
        evaluations!.add(MemberEvaluation.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['feedbacks'] != null) {
      feedbacks = <MemberFeedback>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(MemberFeedback.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (evaluations != null) {
      data['evaluations'] = evaluations!.map((v) => v.toJson()).toList();
    }
    if (feedbacks != null) {
      data['feedbacks'] = feedbacks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
