import 'package:flutter/material.dart';

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
}
