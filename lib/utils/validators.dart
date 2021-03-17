class Validator {
  static String emailValidator(value) {
    if (value.isEmpty) {
      return 'Please enter valid email';
    }
    return null;
  }

  static String defaultValidator(value) {
    if (value.isEmpty) {
      return 'This field cant be empty';
    }
    return null;
  }

  static String passValidator(value) {
    if (value.isEmpty) {
      return 'Password can\'t be empty';
    }
    return null;
  }
}
