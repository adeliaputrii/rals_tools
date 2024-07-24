import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoPopup extends StatelessWidget {
  const SoPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titlePadding: EdgeInsets.only(top: 20),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        width: 500,
        child: Image.asset(
          'assets/statusTask.png',
          height: 200,
        )),
      content: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 160,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
              'PIlih Lokasi',
                style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              minWidth: 350,
              height: 40,
              color: Colors.green,
              onPressed: () {
                Navigator.pop(context, 'Progress');
              },
              child: Text(
              'Progress',
                style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white),
              )
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              minWidth: 350,
              height: 40,
              color: Colors.cyan,
              onPressed: () {
                Navigator.pop(context, 'Closed');
              },
              child: Text(
              'Closed',
                style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white),
              ))
            ],
          )),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    ;
  }
}