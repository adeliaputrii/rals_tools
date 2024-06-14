import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
class DateTimeUtils {
  DateTimeUtils._();
  static DateTime convertStringToDateTime(String timeString) {
    return DateFormat("HH:mm:ss").parse(timeString); 
  }

  static String convertTohhmm(DateTime time) {
    return DateFormat("HH:mm").format(time);
  }

  static DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay, {DateTime? date}) {
  final now = date ?? DateTime.now();
  return DateTime(timeOfDay.hour, timeOfDay.minute);
}
}