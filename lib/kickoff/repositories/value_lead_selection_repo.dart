import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/kickoff/models/value_lead_selection.dart';
import 'package:mevn_app/kickoff/services/value_lead_selection_service.dart';

class ValueLeadSelectionRepo extends BaseRepository {
  final ValueLeadSelectionService valueLeadSelectionService;

  ValueLeadSelectionRepo({
    required this.valueLeadSelectionService,
  });

  Future<List<String>?> getListValueIsCheck() {
    return valueLeadSelectionService.getListValueIsCheck();
  }

  Future<Either<ValueLeadSelection, Exception>> sendSelection(
    ValueLeadSelection param,
  ) {
    return safeCall(() => valueLeadSelectionService.sendSelection(param));
  }
}
