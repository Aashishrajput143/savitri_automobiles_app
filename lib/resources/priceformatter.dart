import 'package:intl/intl.dart';

class PriceFormatter {
  static String formatPrice(int price) {
    final NumberFormat formatter = NumberFormat("#,##,##0");
    return formatter.format(price);
  }
}
