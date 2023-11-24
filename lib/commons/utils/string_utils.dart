const phoneRegex = r"^[62][0-9]$";

class StringUtils {
  static bool isValidPhoneNumber(String value) {
    return RegExp(phoneRegex).hasMatch(value);
  }
}
