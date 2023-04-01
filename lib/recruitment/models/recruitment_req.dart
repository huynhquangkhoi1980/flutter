class RecruitmentReq {
  String? fullName;
  String? email;
  String? phone;
  String? skill;
  String? aboutMe;

  RecruitmentReq({
    this.fullName,
    this.email,
    this.phone,
    this.skill,
    this.aboutMe,
  });

  RecruitmentReq.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'] as String;
    email = json['email'] as String;
    phone = json['phone'] as String;
    skill = json['skill'] as String;
    aboutMe = json['aboutMe'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['skill'] = skill;
    data['about_me'] = aboutMe;
    return data;
  }
}
