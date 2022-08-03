class Team {
  String? name;
  List<String>? members;
  List<String>? projects;

  Team({
    this.name,
    this.members,
    this.projects,
  });

  Team.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    members = json['members'].cast<String>() as List<String>?;
    projects = json['projects'].cast<String>() as List<String>?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['members'] = members;
    data['projects'] = projects;
    return data;
  }
}
