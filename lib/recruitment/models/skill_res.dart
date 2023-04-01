import 'package:mevn_app/recruitment/models/skill.dart';

class SkillRes {
  List<Skill>? skills;

  SkillRes({this.skills});

  SkillRes.fromJson(List<dynamic> json) {
    skills = <Skill>[];

    // ignore: avoid_function_literals_in_foreach_calls
    json.forEach((v) {
      skills!.add(Skill.fromJson(v as Map<String, dynamic>));
    });
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (skills != null) {
      data['skills'] = skills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
