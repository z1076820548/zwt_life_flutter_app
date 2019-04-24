//小说格式化
import 'package:intl/intl.dart';

class FormatUtil {
  static final int ONE_MINUTE = 60000;
  static final int ONE_HOUR = 3600000;
  static final int ONE_DAY = 86400000;
  static final int ONE_WEEK = 604800000;

  static final String ONE_SECOND_AGO = "秒前";
  static final String ONE_MINUTE_AGO = "分钟前";
  static final String ONE_HOUR_AGO = "小时前";
  static final String ONE_DAY_AGO = "天前";
  static final String ONE_MONTH_AGO = "月前";
  static final String ONE_YEAR_AGO = "年前";

  static final String FORMAT_DATE_TIME = "yyyy-MM-dd HH:mm:ss.SSS";

//   static final DateFormat sdf = new DateFormat(FORMAT_DATE_TIME);

  /**
   * 获取当前日期的指定格式的字符串
   *
   * @param format 指定的日期时间格式，若为null或""则使用指定的格式"yyyy-MM-dd HH:mm:ss.SSS"
   * @return
   */
  static String getCurrentTimeString(String newPattern) {
    if (newPattern == null || newPattern.trim().isEmpty) {
      return dateToS(new DateTime.now(), FORMAT_DATE_TIME);
    } else {
      return dateToS(new DateTime.now(), newPattern);
    }
  }

  /**
   * 根据时间字符串获取描述性时间，如3分钟前，1天前
   *
   * @param dateString 时间字符串
   * @return
   */
  static String getDescriptionTimeFromDateString(String dateString) {
    if (dateString.isEmpty) {
      return "";
    } else {
      return getDescriptionTimeFromDate(
          sToDate(formatZhuiShuDateString(dateString)));
    }
  }

  /**
   * 格式化追书神器返回的时间字符串
   *
   * @param dateString 时间字符串
   * @return
   */
  static String formatZhuiShuDateString(String dateString) {
    return dateString.replaceAll("T", " ").replaceAll("Z", "");
  }

  /**
   * 根据Date获取描述性时间，如3分钟前，1天前
   *
   * @param date
   * @return
   */
  static String getDescriptionTimeFromDate(DateTime date) {
    int delta =
        DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    if (delta < 1 * ONE_MINUTE) {
      int seconds = toSeconds(delta);
      return (seconds <= 0 ? 1 : seconds).toString() + ONE_SECOND_AGO;
    }
    if (delta < 45 * ONE_MINUTE) {
      int minutes = toMinutes(delta);
      return (minutes <= 0 ? 1 : minutes).toString() + ONE_MINUTE_AGO;
    }
    if (delta < 24 * ONE_HOUR) {
      int hours = toHours(delta);
      return (hours <= 0 ? 1 : hours).toString() + ONE_HOUR_AGO;
    }
    if (delta < 48 * ONE_HOUR) {
      return "昨天";
    }
    if (delta < 30 * ONE_DAY) {
      int days = toDays(delta);
      return (days <= 0 ? 1 : days).toString() + ONE_DAY_AGO;
    }
    if (delta < 12 * 4 * ONE_WEEK) {
      int months = toMonths(delta);
      return (months <= 0 ? 1 : months).toString() + ONE_MONTH_AGO;
    } else {
      int years = toYears(delta);
      return (years <= 0 ? 1 : years).toString() + ONE_YEAR_AGO;
    }
  }

  static DateTime sToDate(String formattedString) {
    return DateTime.parse(formattedString);
  }

  static String dateToS(DateTime datetime, String newPattern) {
    return DateFormat(newPattern).format(datetime);
  }

  static int toSeconds(int date) {
    return date ~/ 1000;
  }

  static int toMinutes(int date) {
    return toSeconds(date) ~/ 60;
  }

  static int toHours(int date) {
    return toMinutes(date) ~/ 60;
  }

  static int toDays(int date) {
    return toHours(date) ~/ 24;
  }

  static int toMonths(int date) {
    return toDays(date) ~/ 30;
  }

  static int toYears(int date) {
    return toMonths(date) ~/ 365;
  }

  static String wordCount(int wordCount) {
    if ((wordCount ~/ 10000) > 0) {
      int count = wordCount ~/ 10000;
      String s = count.toString() + "万字";
      return s;
    } else if ((wordCount ~/ 1000) > 0) {
      int count = wordCount ~/ 1000;
      String s = count.toString() + "千字";
      return s;
    } else {
      int count = wordCount;
      String s = count.toString() + "字";
      return s;
    }
  }
}
