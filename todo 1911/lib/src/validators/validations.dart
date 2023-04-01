class Validation {
  // Check UserName not null && its lenth >=6 and include @ charater
  static bool isValidUser(String user) {
    return user.length >= 6 && user.contains("@");
  }

  // Check Password lenth >= 6
  static bool isValidPass(String pass) {
    return pass.length >= 6;
  }

  // Check Phonenumber length = 10
  static bool isValidPhonenumber(String phoneNumber) {
    try {
      return (int.parse(phoneNumber) is int && phoneNumber.length == 10);
    } catch (e) {
      return false;
    }
  }

  // Check Email length <= 10 and contains @
  static bool isValidEmail(String email) {
    // return email != null && email.length >= 6 && email.contains("@");
    return email.length >= 6 && email.contains("@");
  }

  // Check Name length >= 6
  static bool isValidName(String name) {
    return name.length >= 6;
  }
}
