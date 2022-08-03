import 'package:mevn_app/app/utils/models/auth.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/app/utils/services/auth_service.dart';

class AuthRepo extends BaseRepository {
  final AuthService authService;

  AuthRepo({required this.authService});

  Future<Auth> getAuth() {
    return authService.getAuth();
  }

  Future<bool> checkAuthentication() async {
    return authService.checkAuthentication();
  }

  Future login() {
    return authService.login();
  }

  Future logout() {
    return authService.logout();
  }
}
