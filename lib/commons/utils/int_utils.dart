import 'package:intl/intl.dart';

class IntUtils {
  static String convertToRupiahCurrency(int value) {
    final currencyFormat = NumberFormat.currency(
      locale: "id",
      symbol: "Rp ",
      decimalDigits: 2,
    );

    return currencyFormat.format(value);
  }

  static String convertToDecimal(int value) {
    return NumberFormat.decimalPattern('id_ID').format(value);
  }
}
