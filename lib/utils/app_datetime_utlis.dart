import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
class DateTimeUtils {
  DateTimeUtils._();
  static DateTime convertStringToDateTime(String timeString) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(timeString);
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      parsedTime.hour,
      parsedTime.minute,
      parsedTime.second
    );
    return dateTime;
  }

  static String convertTohhmm(DateTime time) {
    return DateFormat("HH:mm").format(time);
  }

  static DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay, {DateTime? date}) {
  final now = date ?? DateTime.now();
  return DateTime(timeOfDay.hour, timeOfDay.minute);
}
}