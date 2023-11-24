class LogUtils {
  static void info(String message) {
    print("System Info: $message");
  }

  static void error(String message) {
    final errorMessage = "System Error: $message";

    print(errorMessage);
  }
}
