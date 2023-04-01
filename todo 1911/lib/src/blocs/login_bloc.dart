import 'dart:async';

import 'package:todo/src/validators/validations.dart';

class LoginBloc {
  final _userNameErr = "UserName is invalid!";
  final _passErr = "Password lenght more than 6 characters!";

  final StreamController _userController = StreamController();
  final StreamController _passController = StreamController();

  // Create Stream due to use in login_page.dart
  Stream get userStream => _userController.stream;
  Stream get passStream => _passController.stream;
  // the same way to create the above one
  // Stream getUserStream() {
  //   return _userController.stream;
  // }

  bool isValidInfo(String userName, String pass) {
    bool flgValidInfo = true;

    if (!Validation.isValidUser(userName)) {
      // Put into stream an error when user Name is invalid
      _userController.sink.addError(_userNameErr);
      flgValidInfo = false;
    } else {
      _userController.sink.addError("");
      // UserName is ok
      _userController.sink.add("OK");
    }

    if (!Validation.isValidPass(pass)) {
      _passController.sink.addError(_passErr);
      flgValidInfo = false;
    }else {
      _passController.sink.addError("");
      // UserName is ok
      _passController.sink.add("OK");
    }

    // If has any error, return false. 
    if (flgValidInfo == false) return false;

    return true;
  }

  // Stream always listening so must detroy it when we do not need to use it
  void dispose() {
    _userController.close();
    _passController.close();
  }
}
