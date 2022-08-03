import 'package:mevn_app/kickoff/models/team.dart';

class TeamsRes {
  List<Team>? teams;

  TeamsRes({this.teams});

  TeamsRes.fromJson(Map<String, dynamic> json) {
    if (json['teams'] != null) {
      teams = <Team>[];
      json['teams'].forEach((v) {
        teams!.add(Team.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
