
import 'package:intl/intl.dart';

const String appDateFormat = 'EEEE, dd MMM yyyy';

onlyDate({required DateTime now}) {
  return DateTime(now.year, now.month, now.day);
}

onlyDateTimestamp({required DateTime? now}) {
  if (now == null) {
    return null;
  }
  return DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
}

onlyDateStringFromDateTime({required DateTime? now, String format = appDateFormat}) {
  if (now == null) {
    return null;
  }
  return DateFormat(format).format(now);
}

onlyDateStringFromTimestamp({required int? timestamp, String format = appDateFormat}) {
  if (timestamp == null) {
    return null;
  }
  DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  return onlyDateStringFromDateTime(now: dateTime, format: format);
}

getToday() {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

getLastNDayTimestamp({int dueDay = 0}) {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day).subtract(Duration(days: dueDay));
}

getLastNHourTimestamp({int dueHour = 0}) {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day).subtract(Duration(hours: dueHour)).millisecondsSinceEpoch;
}

getLastNMonthTimestamp({int dueMonth = 0}) {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month - dueMonth, 1).millisecondsSinceEpoch;
}

getDayNameFromTimestamp(int timestamp) {
  DateFormat formatter = DateFormat('dd MMM');
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return formatter.format(dateTime);
}
