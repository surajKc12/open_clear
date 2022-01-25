class Validation
{
  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Invalid Password';
    } else {
      return null;
    }
  }
  static String? validateName(String? value) {
    if (value == null || value.length < 3) {
      return 'Invalid Name';
    } else {
      return null;
    }
  }
  static String? validateDescription(String? value) {
    if (value == null || value.length < 2) {
      return 'Invalid Description';
    } else {
      return null;
    }
  }
  static String? validateEmail(String? value) {
    if (value == null || !(value.contains('.') && value.contains('@'))) {
      return 'Invalid Email address';
    } else {
      return null;
    }
  }
}