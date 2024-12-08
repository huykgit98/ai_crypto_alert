import 'package:intl/intl.dart';

class DateUtil {
  // Static method to format a string date (non-nullable)
  static String formatDate(String dateString, {String pattern = 'dd/MM/yyyy'}) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat(pattern).format(dateTime);
    } catch (e) {
      return dateString; // Fallback to original string if parsing fails
    }
  }

  // Static method to format a string date with time (non-nullable)
  static String formatDateTime(String dateString,
      {String pattern = 'HH:mm dd/MM/yyyy'}) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat(pattern).format(dateTime);
    } catch (e) {
      return dateString; // Fallback to original string if parsing fails
    }
  }

  // Static method to format a nullable DateTime object
  static String formatDateNullable(DateTime? dateTime,
      {String pattern = 'dd/MM/yyyy'}) {
    if (dateTime == null) return 'Invalid date';
    try {
      return DateFormat(pattern).format(dateTime);
    } catch (e) {
      return 'Invalid date'; // Fallback if something goes wrong
    }
  }

  // Static method to convert DateTime to UTC string format
  static String dateTimeToUtcString(DateTime dateTime) {
    return '${dateTime.toIso8601String()}Z';
  }

  // Method to handle nullable string and DateTime parsing
  static String formatNullableDateString(String? dateString,
      {String pattern = 'dd/MM/yyyy'}) {
    if (dateString == null || dateString.isEmpty) return 'Invalid date';
    try {
      final dateTime = DateTime.tryParse(dateString);
      return dateTime != null
          ? DateFormat(pattern).format(dateTime)
          : 'Invalid date'; // Fallback if parsing fails
    } catch (e) {
      return 'Invalid date'; // Fallback to an error message if parsing fails
    }
  }
}
