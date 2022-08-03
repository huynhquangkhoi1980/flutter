import 'package:mevn_app/kickoff/models/sub_project.dart';

class SubProjectRes {
  List<SubProject>? projects;

  SubProjectRes({this.projects});

  SubProjectRes.fromJson(Map<String, dynamic> json) {
    if (json['projects'] != null) {
      projects = <SubProject>[];
      json['projects'].forEach((v) {
        projects!.add(SubProject.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (projects != null) {
      data['projects'] = projects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
