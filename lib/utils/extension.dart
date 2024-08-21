import 'package:intl/intl.dart';

extension IntExt on int {
  String toIdr() {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
        .format(this);
  }
}

extension StringExt on String {
  double toDouble() {
    return double.tryParse(this) ?? 0.0;
  }

  String formatDate() {
    DateTime originalDateTime = DateTime.parse(this);
    return DateFormat("yyyy-MM-dd HH:mm").format(originalDateTime);
  }
}
