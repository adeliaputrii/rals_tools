
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColor;
import 'package:myactivity_project/database/StockOpname/db_get_data.dart';
import 'package:myactivity_project/database/StockOpname/db_save_data.dart';

class PopUpWidget {
  DbSoSaveData dbSave = DbSoSaveData();
  DbSoGetData db = DbSoGetData();
  final BuildContext context;
  PopUpWidget(this.context);

  showPopUpError(String title, String description) {
    return MotionToast(
      toastDuration: Duration(seconds: 4),
      icon: Icons.error,
      primaryColor: Colors.red,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
      ),
      width: 350,
      backgroundType: BackgroundType.lighter,
      height: 100,
      description: Text(
        description,
        style: TextStyle(fontSize: 15),
      ),
      //description: "Center displayed motion toast",
      position: MotionToastPosition.center,
    ).show(context);
  }

  showPopUpWarning(String message, String confirmBtnText) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.warning,
      text: message,
      confirmBtnText: confirmBtnText,
      confirmBtnColor: Colors.green,
      
    );
  }

  showPopUpSuccess(String message, String confirmBtnText, Function function) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: message,
      confirmBtnText: confirmBtnText,
      cancelBtnText: 'Kembali',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () {
        function();
      },
    );
  }

  

  showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: baseColor.primaryColor,
        textColor: Colors.white,
        fontSize: 12.0);
  }

  showPopupSuccess() {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: 'Berhasil',
      confirmBtnText: 'Ya',
      cancelBtnText: 'Tidak',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () {
        Navigator.pop(context);
      },
    );
  }

  showPopupSucces(String text, String message) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      title: text,
      text: message,
      // confirmBtnText: 'Ya',
      cancelBtnText: 'Tidak',
      confirmBtnColor: Colors.green,
      // onConfirmBtnTap: () {
      //   Navigator.pop(context);
      // },
    );
  }
}
