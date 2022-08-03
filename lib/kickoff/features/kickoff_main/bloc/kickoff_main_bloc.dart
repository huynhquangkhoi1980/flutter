import 'package:bloc/bloc.dart';
import 'package:mevn_app/kickoff/features/kickoff_main/bloc/kickoff_main_state.dart';
import 'package:mevn_app/kickoff/repositories/action_submit_repo.dart';

class KickoffMainBloc extends Cubit<KickoffMainState> {
  final ActionSubmitRepo actionSubmitRepo;
  KickoffMainBloc(this.actionSubmitRepo) : super(InKickoffMainState());

  void getMenu() async {
    emit(LoadingState());
    final res = await actionSubmitRepo.getMenu();
    emit(KickoffMainsLoadedState(res));
  }

  Future<List<String>?> getMenuIsSubmit() async {
    return actionSubmitRepo.getMenuIsSubmit();
  }
}
