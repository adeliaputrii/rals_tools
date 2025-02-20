import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColor;

class MemberReport extends StatefulWidget {
  const MemberReport({super.key});

  @override
  State<MemberReport> createState() => _MemberReport();
}

class _MemberReport extends State<MemberReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Member',
          style: GoogleFonts.plusJakartaSans(
              fontSize: 23, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 131, 113, 113),
          ),
        ),
        backgroundColor: baseColor.primaryColor,
      ),
      body: Center(child: Text("Member Report Content")),
    );
  }
}
