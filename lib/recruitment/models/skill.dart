class Skill {
  int? id;
  String? name;
  String? description;
  int? sortOrder;
  String? createdAt;
  String? updatedAt;

  Skill({
    this.id,
    this.name,
    this.description,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  Skill.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    description = json['description'] as String;
    sortOrder = json['sort_order'] as int;
    createdAt = json['created_at'] as String;
    updatedAt = json['updated_at'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['sort_order'] = sortOrder;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
