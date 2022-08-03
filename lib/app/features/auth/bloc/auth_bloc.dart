import 'package:bloc/bloc.dart';
import 'package:mevn_app/app/features/auth/bloc/auth_state.dart';
import 'package:mevn_app/app/utils/repositories/auth_repo.dart';

class AuthBloc extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  AuthBloc(this._authRepo) : super(InAuthState());

  void loadedApp() async {
    emit(LoadedAppState());
  }

  void checkAuthentication() async {
    emit(LoadedAppState());
    final isChecked = await _authRepo.checkAuthentication();
    emit(AuthenticationState(isChecked));
    final user = await _authRepo.getAuth();
    emit(LoginState(user));
  }

  void login() async {
    emit(LoadedAppState());
    final user = await _authRepo.login();
    if (user == null) {
      emit(AuthenticationState(false));
    } else {
      emit(LoginState(user));
    }
  }

  void loadedAuth() async {
    emit(LoadedAppState());
    final user = await _authRepo.getAuth();
    emit(LoginState(user));
  }

  void logout() async {
    emit(LoadedAppState());
    await _authRepo.logout();
    emit(LogoutState());
  }
}
