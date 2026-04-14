import 'package:intl/intl.dart';

class CustomDateFormatter {
  static const String _defaultFormat = 'MMM dd, yyyy';
  static const String _timeFormat = 'hh:mm a';
  static const String _dateTimeFormat = 'MMM dd, yyyy  hh:mm a';

  // শুধু Date
  static String formatDate(String dateStr) {
    try {
      DateTime date = DateTime.parse(dateStr).toLocal();
      return DateFormat(_defaultFormat).format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  // শুধু Time
  static String formatTime(String dateStr) {
    try {
      DateTime date = DateTime.parse(dateStr).toLocal();
      return DateFormat(_timeFormat).format(date);
    } catch (e) {
      return 'Invalid Time';
    }
  }

  // Date + Time একসাথে
  static String formatDateTime(String dateStr) {
    try {
      DateTime date = DateTime.parse(dateStr).toLocal();
      return DateFormat(_dateTimeFormat).format(date);
    } catch (e) {
      return 'Invalid DateTime';
    }
  }
}