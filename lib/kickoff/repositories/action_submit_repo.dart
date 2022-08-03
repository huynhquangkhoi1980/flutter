import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/kickoff/models/menu_kickoff_req.dart';
import 'package:mevn_app/kickoff/services/kickoff_service.dart';

class ActionSubmitRepo extends BaseRepository {
  final ActionSubmitService actionSubmitService;

  ActionSubmitRepo({required this.actionSubmitService});

  Future<MenuKickoffRes> getMenu() {
    return actionSubmitService.getMenu();
  }

  Future<List<String>?> getMenuIsSubmit() async {
    return actionSubmitService.getMenuIsSubmit();
  }
}
