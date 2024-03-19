import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColors;

import 'package:google_fonts/google_fonts.dart';

class DateTimeUtils {
  DateTimeUtils._();
  static DateTime convertStringToDateTime(String timeString) {
    return DateFormat("HH:mm:ss").parse(timeString); // Sesuaikan dengan format waktu dari API
  }

  static String convertTohhmm(DateTime time) {
    return DateFormat("HH:mm").format(time);
  }

  static Future<DateTime?> openTimePickerSheet(BuildContext context) async {
    final result = await TimePicker.show<DateTime?>(
      context: context,
      sheet: TimePickerSheet(
        initialDateTime: DateTime.now(),
        minuteInterval: 1,
        twoDigit: true,
        sheetTitle: 'Pilih Waktu',
        minuteTitle: 'Menit',
        hourTitle: 'Jam',
        saveButtonText: 'Simpan',
        saveButtonColor: baseColors.primaryColor,
        sheetCloseIconColor: baseColors.primaryColor,
        sheetTitleStyle: GoogleFonts.plusJakartaSans(fontSize: 23, color: Colors.black),
        hourTitleStyle: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
        minuteTitleStyle: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
        wheelNumberItemStyle: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
        wheelNumberSelectedStyle: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
      ),
    );

    return result;
  }
}
