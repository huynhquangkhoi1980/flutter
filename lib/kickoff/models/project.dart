class Project {
  String? name;
  List<String>? owner;
  String? pm;
  String? goal;
  String? description;
  String? thumbnail;
  String? website;
  int? numberOfEngineers;

  Project({
    this.name,
    this.owner,
    this.pm,
    this.goal,
    this.description,
    this.thumbnail,
    this.website,
    this.numberOfEngineers,
  });

  Project.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    owner = json['owner'].cast<String>() as List<String>?;
    pm = json['pm'] as String?;
    goal = json['goal'] as String?;
    description = json['description'] as String?;
    thumbnail = json['thumbnail'] as String?;
    website = json['website'] as String?;
    numberOfEngineers = json['number_of_engineers'] as int?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['pm'] = pm;
    data['goal'] = goal;
    data['description'] = description;
    data['thumbnail'] = thumbnail;
    data['website'] = website;
    data['number_of_engineers'] = numberOfEngineers;
    return data;
  }
}
