import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class PopUpWidget {
  final BuildContext context;
  PopUpWidget(this.context);

  showPopUp(String title, String description) {
    return MotionToast(
      toastDuration: Duration(seconds: 4),
      icon: Icons.error,
      primaryColor: Colors.red,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
}
