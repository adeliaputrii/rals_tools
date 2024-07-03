import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColor;

PreferredSize appBarCustom(Widget? route, String title, Function? widgetFunction, BuildContext ctx){
    return PreferredSize(
    preferredSize: Size.fromHeight(70),
    child: AppBar(
      backgroundColor: baseColor.primaryColor,
      leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              ctx,
              MaterialPageRoute(
                  builder: (context) => route!
              ),
              (Route<dynamic> route) => false
            );
          },
          icon: const Icon(Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          )
      ),
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w500
        ),
      ),
      actions: [
          widgetFunction!()
      ],
    ),
  );
}