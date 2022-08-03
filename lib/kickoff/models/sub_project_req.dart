class SubProjectReq {
  List<String>? pjs;
  String? userEmail;

  SubProjectReq({this.pjs, this.userEmail});

  SubProjectReq.fromJson(Map<String, dynamic> json) {
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
