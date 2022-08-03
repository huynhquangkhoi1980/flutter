import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/kickoff/models/tech_lead_selection.dart';
import 'package:mevn_app/kickoff/services/tech_lead_selection_service.dart';

class TechLeadSelectionRepo extends BaseRepository {
  final TechLeadSelectionService techLeadSelectionService;

  TechLeadSelectionRepo({
    required this.techLeadSelectionService,
  });

  Future<List<String>?> getListTechIsCheck() {
    return techLeadSelectionService.getListTechIsCheck();
  }

  Future<Either<TechLeadSelection, Exception>> sendSelection(
    TechLeadSelection param,
  ) {
    return safeCall(() => techLeadSelectionService.sendSelection(param));
  }
}
