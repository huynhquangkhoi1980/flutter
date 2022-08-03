class TeamEvaluation {
  int? id;
  String? question;
  bool? value;
  String? sQuestionJa;

  TeamEvaluation({
    this.id,
    this.question,
    this.value,
    this.sQuestionJa,
  });

  TeamEvaluation.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    question = json['question'] as String?;
    value = json['value'] as bool?;
    sQuestionJa = json['_question_ja'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['value'] = value;
    data['_question_ja'] = sQuestionJa;
    return data;
  }
}
