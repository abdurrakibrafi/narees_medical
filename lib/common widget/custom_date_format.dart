import 'package:intl/intl.dart';

class CustomDateFormatter {
  static const String _defaultFormat = 'MMM dd, yyyy';

  static String formatDate(String dateStr) {
    try {
      DateTime date = DateTime.parse(dateStr);

      return DateFormat(_defaultFormat).format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
