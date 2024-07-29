import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoPopup extends StatefulWidget {
  const SoPopup({super.key});

  @override
  State<SoPopup> createState() => _SoPopupState();
}

class _SoPopupState extends State<SoPopup> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titlePadding: EdgeInsets.all(5),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        width: 500,
        child: Image.asset(
          'assets/location.png',
          height: 180,
        )
      ),
      content: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 120,
        child: Column(
          children: [
            Text(
            'Pilih Lokasi',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18, 
                color: Colors.black, 
                fontWeight: FontWeight.w500
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                minWidth: screenWidth,
                height: 40,
                color: Colors.green,
                onPressed: () {
                  Navigator.pop(context, {
                    'location' : 'Location Basement'
                  });
                },
                child: Text(
                'Location Basement',
                  style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white),
                )
              ),
            )
            ],
          )),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    ;
  }
}