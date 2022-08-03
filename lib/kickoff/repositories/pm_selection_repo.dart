import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/kickoff/models/pm_selection.dart';
import 'package:mevn_app/kickoff/services/pm_selection_service.dart';

class PmSelectionRepo extends BaseRepository {
  final PmSelectionService pmSelectionService;

  PmSelectionRepo({
    required this.pmSelectionService,
  });

  Future<List<String>?> getListPMIsCheck() {
    return pmSelectionService.getListPMIsCheck();
  }

  Future<Either<PmSelection, Exception>> sendSelection(
    PmSelection param,
  ) {
    return safeCall(() => pmSelectionService.sendSelection(param));
  }
}
