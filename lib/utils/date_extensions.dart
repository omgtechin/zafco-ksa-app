import 'package:intl/intl.dart';

extension FormattedStringDateTime on String {
  String getyMMMEdDate() {
    try {
      final date = DateTime.parse(this);
      // ignore: noop_primitive_operations
      return DateFormat().add_yMMMEd().format(date).toString();
    } catch (e) {
      try {
        final date = DateFormat('dd-MM-yyyy');
        final parsed = date.parse(this);
        // ignore: noop_primitive_operations
        return DateFormat().add_yMMMEd().format(parsed).toString();
      } catch (e) {
        return this;
      }
    }
  }
}
