import 'dart:async';

import 'package:todo/src/fire_base/fire_base_auth.dart';
import 'package:todo/src/validators/validations.dart';

class AuthBloc {
  final _firAuth = FirAuth();

  final StreamController _nameController = StreamController();
  final StreamController _emailController = StreamController();
  final StreamController _passController = StreamController();
  final StreamController _phoneController = StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;
  Stream get phoneStream => _phoneController.stream;

  bool isValid(String name, String email, String pass, String phone) {
    bool flgValidInfo = true;

    if (!Validation.isValidName(name)) {
      _nameController.sink.addError("Input Name");
      flgValidInfo = false;
    } else {
      _nameController.sink.addError("");
      _nameController.sink.add("OK");
    }

    if (!Validation.isValidPhonenumber(phone)) {
      _phoneController.sink.addError("Input Phone");
      flgValidInfo = false;
    } else {
      _phoneController.sink.addError("");
      _phoneController.sink.add("OK");
    }

    if (!Validation.isValidEmail(email)) {
      _emailController.sink.addError("Input Email");
      flgValidInfo = false;
    } else {
      _emailController.sink.addError("");
      _emailController.sink.add("OK");
    }

    if (!Validation.isValidPass(pass)) {
      _passController.sink.addError("Input Password");
      flgValidInfo = false;
    } else {
      _passController.sink.addError("");
      _passController.sink.add("OK");
    }

    // If has any error, return false.
    if (flgValidInfo == false) return false;

    return true;
  }

  void signUp(String email, String pass, String phone, String name,
      Function onSuccess, Function(String) onRegisterError) {
    _firAuth.signUp(email, pass, name, phone, onSuccess, onRegisterError);
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuth.signIn(email, pass, onSuccess, onSignInError);
  }

  void signOut(Function onSuccess, Function(String) onSignInError) {
    _firAuth.signOut(onSuccess, onSignInError);
  }

  // Destroy
  void dispose() {
    _nameController.close();
    _emailController.close();
    _passController.close();
    _phoneController.close();
  }
}
