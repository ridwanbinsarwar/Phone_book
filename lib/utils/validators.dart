class Validator {
  static String defaultValidator(value) {
    if (value.isEmpty) {
      return 'This field cant be empty';
    }
    return null;
  }

  static String emailValidator(value) {
    return null;
    if (!value.isEmpty &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"
                r"@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
      return null;
    }
    return 'Please enter valid email';
  }

  static String passValidator(value) {
    return null;
    if (value.isEmpty) {
      return 'Password can\'t be empty';
    }
    if (value.length < 8) {
      return 'Password can\'t be less than 8 characters';
    }
    return null;
  }

  static String phoneValidator(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
