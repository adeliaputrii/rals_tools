part of 'import.dart';

class RamayanaLoginOffline extends StatefulWidget {
  const RamayanaLoginOffline({super.key});

  @override
  State<RamayanaLoginOffline> createState() => _RamayanaLoginOfflineState();
}

class _RamayanaLoginOfflineState extends State<RamayanaLoginOffline> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController uniqNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 210, 14, 0),
        toolbarHeight: 0,
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 300,
                color: Color.fromARGB(255, 210, 14, 0),
              ),
              Container(
                // margin: EdgeInsets.only(top: 30),
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
                margin: EdgeInsets.fromLTRB(20, 50, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Login Offline',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 40,
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
                margin: EdgeInsets.only(top: 200),
                child:  Container(
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: FadeInImageWidget(imageUrl: "assets/loginOff.png")),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 10, top: 10),
                          child: Text('Password',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 19
                          ),
                          ),
                        ),
                        TextFormField(
                           style: GoogleFonts.plusJakartaSans(
                            color: Colors.black,
                            fontSize: 17
                          ),
                          validator: RequiredValidator(
                            errorText: 'Masukkan Password'
                            ),
                          controller: password,
                          decoration: InputDecoration(
                            prefixIcon: Icon(IconlyLight.lock),
                            errorBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                             color: const Color.fromARGB(255, 255, 0, 0)),
                             borderRadius: BorderRadius.circular(60)),
                            focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                             color: Color.fromARGB(255, 29, 37, 127)),
                             borderRadius: BorderRadius.circular(60)),
                            enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                             color: Colors.black),
                             borderRadius: BorderRadius.circular(60)),
                            disabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                             color: Colors.black),
                             borderRadius: BorderRadius.circular(60)),
                            border: OutlineInputBorder(
                             borderSide: BorderSide(
                             color: Colors.black),
                             borderRadius: BorderRadius.circular(60)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 10, top: 10),
                          child: Text('Nomor Unik',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 19
                          ),
                          ),
                        ),
                        TextFormField(
                          controller: uniqNumber,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.black,
                            fontSize: 17
                          ),
                          validator: RequiredValidator(
                            errorText: 'Masukkan Nomor Unik'
                            ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(IconlyLight.password),
                            errorBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                             color: const Color.fromARGB(255, 255, 0, 0)),
                             borderRadius: BorderRadius.circular(60)),
                            focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                             color: Color.fromARGB(255, 29, 37, 127)),
                             borderRadius: BorderRadius.circular(60)),
                            enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                             color: Colors.black),
                             borderRadius: BorderRadius.circular(60)),
                            disabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                             color: Colors.black),
                             borderRadius: BorderRadius.circular(60)),
                            border: OutlineInputBorder(
                             borderSide: BorderSide(
                             color: Colors.black),
                             borderRadius: BorderRadius.circular(60)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 50, 10, 0),
                          child: MaterialButton(
                            minWidth: 500,
                            height: 50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                            ),
                            color: Color.fromARGB(255, 210, 14, 0),
                            onPressed: () {
                              if(formKey.currentState!.validate()) {
                              Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  RamayanaVoid()),
                              (Route<dynamic> route) => false);
                              }
                            },
                            child: Text('LOGIN',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              color: Colors.white
                            ),
                            ),
                            ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
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
                    ),
                  )),
              ),
             
            ]),
        ],
      ),
    );
  }
}