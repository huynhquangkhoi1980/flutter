class MemberFeedback {
  int? id;
  String? question;
  String? sQuestionJa;
  String? value;

  MemberFeedback({
    this.id,
    this.question,
    this.sQuestionJa,
    this.value,
  });

  MemberFeedback.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    question = json['question'] as String?;
    sQuestionJa = json['_question_ja'] as String?;
    value = json['value'] as String?;
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
