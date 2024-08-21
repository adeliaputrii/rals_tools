import 'package:flutter/material.dart';

class DeviceMediaQuery{

  double screenWidth (BuildContext context, int size){
    return MediaQuery.of(context).size.width / size;
  }

   double screnHeight (BuildContext context, int size){
    return MediaQuery.of(context).size.height / size;
  }

}