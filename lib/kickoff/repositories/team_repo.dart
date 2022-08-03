import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/kickoff/models/team_res.dart';
import 'package:mevn_app/kickoff/services/team_service.dart';

class TeamRepo extends BaseRepository {
  final TeamService teamService;

  TeamRepo({required this.teamService});

  Future<Either<TeamsRes, Exception>> getdata() {
    return safeCall(teamService.getdata);
  }

  Future<int> getCountTeam() async {
    return teamService.getCountTeam();
  }
}
