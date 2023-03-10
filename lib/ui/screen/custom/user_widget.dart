class UserInfo {
  static String? emailValidator(String? email) {
    if (email?.isEmpty ?? true) {
      return "Please enter your email";
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(email!)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? passValidator(String? password) {
    if (password?.isEmpty ?? true) {
      return 'Enter your password';
    }
    return null;
  }

  static String? phoneValidator(String? phone) {
    if (phone?.isEmpty ?? true) {
      return "Please Enter Your Mobile Number"; //
    } else if (phone?.isNotEmpty ?? true && phone?.length != 10) {
      return "Mobile Number Is Invalid";
    }
    return null;
  }

  static String? fNameValidator(String? fName) {
    if (fName?.isEmpty ?? true) {
      return "Please Enter Your First Name";
    }
    return null;
  }

  static String? lNameValidator(String? lName) {
    if (lName?.isEmpty ?? true) {
      return "Please Enter Your First Name";
    }
    return null;
  }
}
