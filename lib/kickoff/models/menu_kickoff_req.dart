import 'package:mevn_app/kickoff/models/menu_kickoff.dart';

class MenuKickoffRes {
  List<MenuKickoff>? menuKickoff;

  MenuKickoffRes({this.menuKickoff});

  MenuKickoffRes.fromJson(Map<String, dynamic> json) {
    if (json['evaluations'] != null) {
      menuKickoff = <MenuKickoff>[];
      json['evaluations'].forEach((v) {
        menuKickoff!.add(MenuKickoff.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}
