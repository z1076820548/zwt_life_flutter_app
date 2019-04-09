import 'package:intl/intl.dart';

class DateUtil {
  static DateTime sToDate(String formattedString) {
    return DateTime.parse(formattedString);
  }

  static String dateToS(DateTime datetime, String newPattern) {
//    DateFormat('mm:ss', 'en_US').format(date)
    return DateFormat(newPattern).format(datetime);
  }
}
