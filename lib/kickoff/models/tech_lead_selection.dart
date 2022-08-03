class TechLeadSelection {
  List<String>? pms;
  String? userEmail;

  TechLeadSelection({this.pms, this.userEmail});

  TechLeadSelection.fromJson(Map<String, dynamic> json) {
    pms = json['pms'].cast<String>() as List<String>?;
    userEmail = json['user_email'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pms'] = pms;
    data['user_email'] = userEmail;
    return data;
  }
}
