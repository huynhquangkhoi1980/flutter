class MemberEvaluationReq {
  String? userEmail;
  List<dynamic>? feedbacks;
  List<dynamic>? evaluations;
  String? email;

  MemberEvaluationReq({
    this.userEmail,
    this.feedbacks,
    this.evaluations,
    this.email,
  });

  MemberEvaluationReq.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'] as String;
    feedbacks = json['feedbacks'] as List<dynamic>;
    evaluations = json['evaluations'] as List<dynamic>;
    email = json['email'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_email'] = userEmail;
    data['feedbacks'] = feedbacks;
    data['evaluations'] = evaluations;
    data['email'] = email;
    return data;
  }
}
