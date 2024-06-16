
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:intl/intl.dart';

wrapAroundRupee(String amount) {
  NumberFormat numberFormat = NumberFormat.decimalPattern('hi');
  return '₹ ${numberFormat.format(double.parse(amount))}';
}

closeApp() {
  if (Platform.isAndroid) {
    FlutterExitApp.exitApp();
  } else if (Platform.isIOS) {
    FlutterExitApp.exitApp(iosForceExit: true);
  }
}

addNextPage(BuildContext context, Widget nextPage) {
  Navigator.push(context, _createAnimatedRoute(nextPage));
}

replaceNextPage(BuildContext context, Widget nextPage) {
  Navigator.pushReplacement(context, _createAnimatedRoute(nextPage));
}

_createAnimatedRoute(Widget nextPage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => nextPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

getPercent(double total, double amount) {
  double percentage = (amount / total) * 100;
  return percentage;
}

String formatAmount(double amount) {
  if (amount >= 1e7) {
    return '${(amount / 1e7).toStringAsFixed(1)}Cr';
  } else if (amount >= 1e5) {
    return '${(amount / 1e5).toStringAsFixed(1)}L';
  } else if (amount >= 1e3) {
    return '${(amount / 1e3).toStringAsFixed(1)}K';
  } else {
    return formatWithCommas(amount);
  }
}

String formatWithCommas(double amount) {
  final formatter = NumberFormat('#,##,###');
  return formatter.format(amount);
}

List<String> getLastNDays({int dayCount = 7}) {
  List<String> days = [];
  final currentDate = DateTime.now();
  for (int i = 0; i < dayCount; i++) {
    final date = currentDate.subtract(Duration(days: i));
    days.add(DateFormat('EEE').format(date));
  }
  return days;
}

List<String> getLastNMonths({int monthCount = 3}) {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('MMM yy');
  List<String> lastThreeMonths = [];
  for (int i = 0; i < monthCount; i++) {
    DateTime previousMonth = DateTime(now.year, now.month - i, now.day);
    lastThreeMonths.add(formatter.format(previousMonth));
  }
  return lastThreeMonths;
}

List<String> getMonthNamesBetween(int nearestDate, int oldDate) {
  DateTime start = DateTime.fromMillisecondsSinceEpoch(oldDate);
  DateTime end = DateTime.fromMillisecondsSinceEpoch(nearestDate);

  List<String> monthNames = [];
  DateFormat formatter = DateFormat('MMM yyyy');

  // Calculate the total number of months between the two timestamps
  int totalMonths = (end.year - start.year) * 12 + end.month - start.month;
  // Determine the interval
  int interval = totalMonths <= 12 ? 1 : (totalMonths / 12).ceil();

  for (int i = 0; i <= totalMonths; i += interval) {
    DateTime month = DateTime(start.year, start.month + i, 1);
    if (month.isAfter(end)) break;
    monthNames.add(formatter.format(month));
  }

  return monthNames;
}

List<String> getAmountLabels(double minAmount, double maxAmount, int desiredIntervals) {
  List<String> labels = [];

  double range = maxAmount - minAmount;
  int numIntervals = desiredIntervals;

  // Determine the size of each interval
  double intervalSize = range / numIntervals;

  // Generate labels for each interval boundary
  for (int i = 0; i <= numIntervals; i++) {
    double amount = minAmount + (intervalSize * i);
    labels.add(amount.toStringAsFixed(2));
  }
  return labels;
}