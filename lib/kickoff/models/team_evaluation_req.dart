class TeamEvaluationReq {
  List<bool>? evaluations;
  String? name;
  String? userEmail;

  TeamEvaluationReq({
    this.evaluations,
    this.name,
    this.userEmail,
  });

  TeamEvaluationReq.fromJson(Map<String, dynamic> json) {
    evaluations = json['evaluations'].cast<bool>() as List<bool>?;
    name = json['name'] as String?;
    userEmail = json['user_email'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['evaluations'] = evaluations;
    data['name'] = name;
    data['user_email'] = userEmail;
    return data;
  }
}
