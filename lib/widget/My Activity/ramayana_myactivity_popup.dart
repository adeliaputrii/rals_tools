part of 'import.dart';

class MyActivityPopUpStatus extends StatelessWidget {
  const MyActivityPopUpStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      // shadowColor: Colors.black,
      titlePadding: EdgeInsets.only(top: 20),
      title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          // height: 370,
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
                  'PIlih Status Tugas',
                  style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
              MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  minWidth: 350,
                  height: 40,
                  color: Colors.green,
                  onPressed: () {
                    // setState(() {
                    //   widget.status = 'Progress';
                    // });
                    // print(widget.status);
                    Navigator.pop(context, 'Progress');
                  },
                  child: Text(
                    'Progress',
                    style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white),
                  )),
              MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  minWidth: 350,
                  height: 40,
                  color: Colors.cyan,
                  onPressed: () {
                    // setState(() {
                    // widget.status = 'Closed';
                    // });
                    // print(widget.status);
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

class MyActivityAlertFormat extends StatelessWidget {
  const MyActivityAlertFormat({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      // shadowColor: Colors.black,
      titlePadding: EdgeInsets.all(0),
      title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 170,
          width: 2000,
          child: Image.asset(
            'assets/omaigat.png',
          )),
      content: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 30,
        child: Center(
          child: Text(
            'Format Harus .jpg/.jpeg/.png/.docx/.xlsx/.pdf',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
  }
}
