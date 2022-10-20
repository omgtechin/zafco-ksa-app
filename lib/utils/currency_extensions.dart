import 'package:intl/intl.dart';

extension IndianCurrency on num {
  String toIndianCurrency() {
    final currencyFormatter = NumberFormat('##,##,##,##0', 'hi_IN');
    return currencyFormatter.format(this);
  }
}
