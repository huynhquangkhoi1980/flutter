class SubProject {
  String? name;
  String? pm;
  String? goal;
  String? description;
  String? thumbnail;
  int? hoursInWeek;
  int? numberOfEngineers;

  SubProject({
    this.name,
    this.pm,
    this.goal,
    this.description,
    this.thumbnail,
    this.hoursInWeek,
    this.numberOfEngineers,
  });

  SubProject.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    pm = json['pm'] as String?;
    goal = json['goal'] as String?;
    description = json['description'] as String?;
    thumbnail = json['thumbnail'] as String?;
    hoursInWeek = json['hours_in_week'] as int?;
    numberOfEngineers = json['number_of_engineers'] as int?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['pm'] = pm;
    data['goal'] = goal;
    data['description'] = description;
    data['thumbnail'] = thumbnail;
    data['hours_in_week'] = hoursInWeek;
    data['number_of_engineers'] = numberOfEngineers;
    return data;
  }
}
