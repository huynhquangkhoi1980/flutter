class MemberEvaluation {
  int? id;
  String? question;
  String? sQuestionJa;
  bool? value;

  MemberEvaluation({
    this.id,
    this.question,
    this.sQuestionJa,
    this.value,
  });

  MemberEvaluation.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    question = json['question'] as String?;
    sQuestionJa = json['_question_ja'] as String?;
    value = json['value'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['_question_ja'] = sQuestionJa;
    data['value'] = value;
    return data;
  }
}
