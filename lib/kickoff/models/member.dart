class Member {
  String? name;
  String? hireDate;
  String? thumbnail;
  String? position;
  String? email;
  String? slackUserId;
  bool? ignoreEngineerCandidate;

  Member({
    this.name,
    this.hireDate,
    this.thumbnail,
    this.position,
    this.email,
    this.slackUserId,
    this.ignoreEngineerCandidate,
  });

  Member.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    hireDate = json['hire_date'] as String?;
    thumbnail = json['thumbnail'] as String?;
    position = json['position'] as String?;
    email = json['email'] as String?;
    slackUserId = json['slack_user_id'] as String?;
    ignoreEngineerCandidate = json['ignore_Engineer_candidate'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['hire_date'] = hireDate;
    data['thumbnail'] = thumbnail;
    data['position'] = position;
    data['email'] = email;
    data['slack_user_id'] = slackUserId;
    data['ignore_Engineer_candidate'] = ignoreEngineerCandidate;
    return data;
  }
}
