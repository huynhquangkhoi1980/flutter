import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  String? email;
  String? displayName;
  String? photoUrl;
  String? id;

  Auth({
    this.email,
    this.displayName,
    this.photoUrl,
    this.id,
  });

  Auth.fromJson(user) {
    final newUser = user as GoogleSignInAccount;
    email = newUser.email;
    displayName = newUser.displayName;
    id = newUser.id;
    photoUrl =
        'images/members/${email!.replaceAll('.', '_').replaceAll('@marketenterprise_vn', '.png')}';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['displayName'] = displayName;
    data['photoUrl'] = photoUrl;
    data['id'] = id;
    return data;
  }
}
