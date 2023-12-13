part of 'import.dart';

class RamayanaLoginOffline extends StatefulWidget {
  const RamayanaLoginOffline({super.key});

  @override
  State<RamayanaLoginOffline> createState() => _RamayanaLoginOfflineState();
}

class _RamayanaLoginOfflineState extends State<RamayanaLoginOffline> {

  sweatAlert() {
    var alertStyle = AlertStyle(
      titlePadding: EdgeInsets.only(top: 0),
      // animationType: AnimationType.fromRight,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: GoogleFonts.plusJakartaSans(
        fontSize: 19,
        color: Colors.black,
      ),
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: GoogleFonts.plusJakartaSans(
          fontSize: 23, color: Colors.red, fontWeight: FontWeight.w500),
      alertAlignment: Alignment.center,
    );
    Alert(
      style: alertStyle,
      context: context,
      image: FadeInImageWidget(imageUrl: "assets/logout.png"),
      title: 'Log Out',
      desc: "Are you sure you want to log out?",
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(20),
          color: Colors.green,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style:
                GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.white),
          ),
        ),
        DialogButton(
          radius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 210, 14, 0),
          onPressed: () async {
            // AndroidDeviceInfo info = await deviceInfo.androidInfo;
            // var formData = FormData.fromMap({
            //   'progname': 'RALS_TOOLS ',
            //   'versi': '${versi}',
            //   'date_run': '${DateTime.now()}',
            //   'info1': 'Logout Aplikasi RALS',
            //   ' info2':
            //       '${imei} ',

            //   'userid': '${userData.getUsernameID()}',
            //   ' toko': '${userData.getUserToko()}',
            //   ' devicename': '${info.device}',
            //   'TOKEN': 'R4M4Y4N4'
            // });

            // var response = await dio.post('${tipeurl}v1/activity/createmylog',
            //     data: formData);
            // print('berhasil $_udid');
            Navigator.pop(context);
          },
          child: Text(
            "Log Out",
            style:
                GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    ).show();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 210, 14, 0),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => RamayanaLogin()));
                    }, 
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                      size: 20,
                    )
                    ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 100, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Login Offline',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(
                  height: 10,
                ),
                Text('Sign In to continue',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  color: Colors.white,
                ),),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(top: 250),
            child:  Container(
              margin: EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15, left: 10, top: 60),
                    child: Text('Password',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18
                    ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                       borderSide: BorderSide(
                       color: Colors.black, width: 5.0),
                       borderRadius: BorderRadius.circular(60)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15, left: 10, top: 30),
                    child: Text('Nomor Unik',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18
                    ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                       borderSide: BorderSide(
                       color: Colors.black, width: 5.0),
                       borderRadius: BorderRadius.circular(60)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 100, 20, 0),
                    child: MaterialButton(
                      minWidth: 500,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      ),
                      color: Color.fromARGB(255, 210, 14, 0),
                      onPressed: () {},
                      child: Text('LOGIN',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        color: Colors.white
                      ),
                      ),
                      ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 150, 20, 0),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Version ${versi} Copyright RALS',
                          // ini pak?
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            color: Colors.black,
                          )),
                      Icon(
                        Icons.copyright,
                        color: Colors.black,
                        size: 18,
                      ),
                      Text('${copyright}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            color: Colors.black,
                          ))
                    ],
                  )
                  )
                ],
              )),
          ),
         
        ]),
    );
  }
}