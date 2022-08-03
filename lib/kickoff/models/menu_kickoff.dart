class MenuKickoff {
  String? name;
  String? route;
  bool? isChecked;

  MenuKickoff({
    this.name,
    this.route,
    this.isChecked,
  });

  MenuKickoff.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    route = json['route'] as String?;
    isChecked = json['isChecked'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['route'] = route;
    data['isChecked'] = isChecked;
    return data;
  }
}
