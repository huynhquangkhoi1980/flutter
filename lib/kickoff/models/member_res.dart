import 'package:mevn_app/kickoff/models/member.dart';

class MemberRes {
  List<Member>? members;

  MemberRes({this.members});

  MemberRes.fromJson(Map<String, dynamic> json) {
    if (json['members'] != null) {
      members = <Member>[];

      json['members'].forEach((v) {
        members!.add(Member.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
