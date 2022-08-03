import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/kickoff/models/project_req.dart';
import 'package:mevn_app/kickoff/models/project_res.dart';
import 'package:mevn_app/kickoff/services/project_service.dart';

class ProjectRepo extends BaseRepository {
  final ProjectService projectService;

  ProjectRepo({
    required this.projectService,
  });

  Future<List<String>?> getListPjIsCheck() {
    return projectService.getListPjIsCheck();
  }

  Future<Either<int, Exception>> countProject() {
    return safeCall(projectService.countProject);
  }

  Future<Either<ProjectRes, Exception>> getdata() {
    return safeCall(projectService.getdata);
  }

  Future<Either<ProjectReq, Exception>> sendSelection(
    ProjectReq param,
  ) {
    return safeCall(() => projectService.sendSelection(param));
  }
}
