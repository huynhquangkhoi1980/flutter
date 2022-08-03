import 'package:mevn_app/kickoff/models/project.dart';

class ProjectRes {
  List<Project>? projects;

  ProjectRes({this.projects});

  ProjectRes.fromJson(Map<String, dynamic> json) {
    if (json['projects'] != null) {
      projects = <Project>[];
      json['projects'].forEach((v) {
        projects!.add(Project.fromJson(v as Map<String, dynamic>));
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
