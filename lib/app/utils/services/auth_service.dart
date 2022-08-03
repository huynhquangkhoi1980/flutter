import 'package:google_sign_in/google_sign_in.dart';
import 'package:mevn_app/app/utils/models/auth.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final PrefProvider _prefProvider;
  AuthService(this._prefProvider) : super();

  Future<Auth> getAuth() async {
    final user = _googleSignIn.currentUser;
    return Auth.fromJson(user);
  }

  Future login() async {
    try {
      await _googleSignIn.signIn();
      final user = _googleSignIn.currentUser;
      final token = await user?.authentication;
      await _prefProvider.setTokenForApi(token!.idToken!);
      await _prefProvider.setUserEmailForApi(user!.email);
      return Auth.fromJson(user);
    } catch (error) {
      return null;
    }
  }

  Future<bool> checkAuthentication() async {
    GoogleSignInAccount? currentUser;
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? user) {
      currentUser = user;
    });
    return currentUser != null;
  }

  Future logout() async {
    await _prefProvider.removeAll();
    await _googleSignIn.signOut();
    await _googleSignIn.disconnect();
  }
}
