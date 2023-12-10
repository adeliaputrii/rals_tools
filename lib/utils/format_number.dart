import 'package:intl/intl.dart';

extension IntExt on int {
  String toIdr() {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
        .format(this);
  }
}
