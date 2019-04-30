import 'package:intl/intl.dart';

class DateUtil {
  static DateTime sToDate(String formattedString) {
    return DateTime.parse(formattedString);
  }

  static String dateToS(DateTime datetime, String newPattern) {
//    DateFormat('mm:ss', 'en_US').format(date)
    return DateFormat(newPattern).format(datetime);
  }
  static String getDateStr(DateTime date) {
    if (date == null || date.toString() == null) {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }
}
