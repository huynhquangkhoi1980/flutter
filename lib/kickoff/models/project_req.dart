class ProjectReq {
  List<String>? pjs;
  String? userEmail;

  ProjectReq({this.pjs, this.userEmail});

  ProjectReq.fromJson(Map<String, dynamic> json) {
    pjs = json['pjs'].cast<String>() as List<String>?;
    userEmail = json['user_email'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pjs'] = pjs;
    data['user_email'] = userEmail;
    return data;
  }
}
