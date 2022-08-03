import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/kickoff/models/sub_project_req.dart';
import 'package:mevn_app/kickoff/models/sub_project_res.dart';
import 'package:mevn_app/kickoff/services/sub_project_service.dart';

class SubProjectRepo extends BaseRepository {
  final SubProjectService subProjectService;

  SubProjectRepo({required this.subProjectService});

  Future<List<String>?> getListSubPjIsCheck() {
    return subProjectService.getListSubPjIsCheck();
  }

  Future<Either<SubProjectRes, Exception>> getdata() {
    return safeCall(subProjectService.getdata);
  }

  Future<Either<SubProjectReq, Exception>> sendSelection(
    SubProjectReq param,
  ) {
    return safeCall(() => subProjectService.sendSelection(param));
  }
}
