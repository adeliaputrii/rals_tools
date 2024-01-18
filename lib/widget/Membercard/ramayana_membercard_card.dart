part of 'import.dart';

class RamayanaMembercardCard extends StatefulWidget {
  const RamayanaMembercardCard({super.key});

  @override
  State<RamayanaMembercardCard> createState() => _RamayanaMembercardCardState();
}

class _RamayanaMembercardCardState extends State<RamayanaMembercardCard> {
  UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                         RamayanaMembercardAuthentication()
                    ),
                    (Route<dynamic> route) => false);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 23,
                color: Colors.white,
              ),
            ),
            title: Text('Company Card',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 23, 
                    color: Colors.white)),
            backgroundColor: Color.fromARGB(255, 210,14,0),
            toolbarHeight: 80,
          ),
          body: ListView(
            children: [
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30
                        ),
                        child: Center(
                          child: Text('Choose Card',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 26,
                            fontWeight: FontWeight.w500, 
                            color: Colors.black)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                        ),
                        child: Center(
                          child: Text('TRR Card',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20, 
                            color: const Color.fromARGB(255, 210, 14, 0))
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context){
                                return RamayanaMembercardTrr();
                              }));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20,20, 20, 0),
                          child: Container(
                            width: 700,
                            height: 280,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(
                                255, 235, 227, 227),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 136, 131, 131),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(2,4)
                                    )
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/tropikana.png'),
                                      fit: BoxFit.fill),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Rp.25.000.000',
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 25, 
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)
                                                          ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10, right: 10, top: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                    '${userData.getFullname()}',
                                                    style: GoogleFonts.plusJakartaSans(
                                                    fontSize: 16, 
                                                    color: Colors.white)
                                                      ),
                                                Text(
                                                     '${userData.getUsernameID()}',
                                                       style: GoogleFonts.plusJakartaSans(
                                                       fontSize: 16, 
                                                        color: Colors.white)
                                                 ),
                                              ],
                                            ),
                                          ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                      ),
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                        ),
                        child: Center(
                          child: Text('RMS Card',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20, 
                            color: const Color.fromARGB(255, 210, 14, 0))
                          ),
                        ),
                      ),
                        MaterialButton(
                          onPressed: () {
                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context){
                                return RamayanaMembercardRms();
                              }));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20,20, 20, 0),
                          child: Container(
                            width: 700,
                            height: 280,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(
                                255, 235, 227, 227),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  ),
                                   boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 136, 131, 131),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(2,4)
                                    )
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/rms.png'),
                                      fit: BoxFit.fill),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: 130,
                                              left: 20
                                            ),
                                            child: Text(
                                              'Rp.25.000.000',
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 28, 
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)
                                                          ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 20, left: 20),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    '${userData.getFullname()}',
                                                    style: GoogleFonts.plusJakartaSans(
                                                    fontSize: 16, 
                                                    color: Colors.white)
                                                      ),
                                                Text(
                                                     '${userData.getUsernameID()}',
                                                       style: GoogleFonts.plusJakartaSans(
                                                       fontSize: 16, 
                                                        color: Colors.white)
                                                 ),
                                              ],
                                            ),
                                          ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
    );
  }
}