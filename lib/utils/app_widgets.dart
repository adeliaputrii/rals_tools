import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColor;

class AppWidget {
  Widget TextFieldSJ(TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 50,
      child: TextField(
        readOnly: true,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 236, 236, 236),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 236, 236, 236),
            ), //<-- SEE HERE
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 236, 236, 236),
            ), //<-- SEE HERE
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }

  Widget LoadingWidget() {
    return SpinKitThreeBounce(
      color: Color.fromARGB(255, 230, 0, 0),
      size: 50.0,
    );
  }

  Widget ErrorHandler(String message, Function function) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w900, color: baseColor.primaryColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                function();
              },
              child: Text(
                'Refresh',
                style: TextStyle(fontSize: 18, color: baseColor.grayPrimary),
              ))
        ],
      ),
    );
  }
}
