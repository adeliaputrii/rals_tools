part of 'import.dart';

class RamayanaMemberCardDetail extends StatefulWidget {
  RamayanaMemberCardDetail(
      {super.key, required this.typeCard, required this.data});
  final String typeCard;
  final ResponseCompany.DataCompany data;

  @override
  State<RamayanaMemberCardDetail> createState() =>
      _RamayanaMemberCardDetailState();
}

class _RamayanaMemberCardDetailState extends State<RamayanaMemberCardDetail> {
  static UserData userData = UserData();
  bool isOn = false;
  DeviceMediaQuery mediaQuery = DeviceMediaQuery();

  @override
  void initState() {
    super.initState;
  }

  Widget myWidget = Center(
    child: Container(
      key: ValueKey(2),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: 700,
        height: 280,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 227, 227),
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
                offset: Offset(2, 4))
          ],
          image: DecorationImage(
              image: AssetImage('assets/rms.png'), fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 130, left: 20),
              child: Text('Rp.25.000.000',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${userData.getFullname()}',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16, color: Colors.white)),
                  Text('${userData.getUsernameID()}',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
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
                      builder: (context) => RamayanaMembercardCard()),
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
                  fontSize: 23, color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 210, 14, 0),
          elevation: 0,
          toolbarHeight: 80,
        ),
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AnimatedSwitcher(
                            child: Center(
                              child: Container(
                                key: ValueKey(2),
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                  width: 700,
                                  height: 280,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 235, 227, 227),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromARGB(
                                              255, 136, 131, 131),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(2, 4))
                                    ],
                                    image: DecorationImage(
                                        image: typeCard()
                                            ? AssetImage('assets/rms.png')
                                            : AssetImage(
                                                'assets/tropikana.png'),
                                        fit: BoxFit.fill),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 130, left: 20),
                                        child: Text(
                                            '${int.tryParse(widget.data.saldo ?? '0')?.toIdr() ?? "-"}',
                                            style: GoogleFonts.plusJakartaSans(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: 20, left: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('${widget.data.nama}',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        fontSize: 16,
                                                        color: Colors.white)),
                                            Text('${widget.data.nokartu}',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        fontSize: 16,
                                                        color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            duration: Duration(seconds: 1),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Switch(
                              activeColor: Color.fromARGB(255, 210, 14, 0),
                              activeThumbImage: AssetImage(
                                'assets/ramayana(C).png',
                              ),
                              value: isOn,
                              onChanged: (newValue) {
                                isOn = newValue;
                                setState(() {
                                  if (isOn)
                                    myWidget = Center(
                                      child: Container(
                                        key: ValueKey(1),
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                                bottomRight:
                                                    Radius.circular(20),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 136, 131, 131),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(2, 4))
                                              ],
                                              image: DecorationImage(
                                                  image: typeCard()
                                                      ? AssetImage(
                                                          'assets/rms.png')
                                                      : AssetImage(
                                                          'assets/tropikana.png'),
                                                  fit: BoxFit.fill),
                                            ),
                                            child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 190,
                                                    bottom: 20,
                                                    left: 40,
                                                    right: 40),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    debugPrint('${12345}');
                                                  },
                                                  child: Container(
                                                      width: 280,
                                                      height: 35,
                                                      child: SfBarcodeGenerator(
                                                          value: '${12345}',
                                                          backgroundColor:
                                                              Colors.white,
                                                          barColor:
                                                              Colors.black,
                                                          symbology:
                                                              Code128())),
                                                ))),
                                      ),
                                    );
                                  else
                                    myWidget = Center(
                                      child: Container(
                                        key: ValueKey(2),
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                                  color: Color.fromARGB(
                                                      255, 136, 131, 131),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(2, 4))
                                            ],
                                            image: DecorationImage(
                                                image: widget.typeCard == '6'
                                                    ? AssetImage(
                                                        'assets/rms.png')
                                                    : AssetImage(
                                                        'assets/tropikana.png'),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 130, left: 20),
                                                child: Text('Rp.25.000.000',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            fontSize: 28,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 20, left: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        '${userData.getFullname()}',
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white)),
                                                    Text(
                                                        '${userData.getUsernameID()}',
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                });
                              }),
                          Container(
                            margin:
                                EdgeInsets.only(top: 0, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromARGB(255, 197, 18, 19)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/qr.png'),
                                      Text(
                                        'Payment',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: typeCard()
                                        ? baseColor.rmsColor
                                        : baseColor.trrColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/history.png',
                                      ),
                                      Text(
                                        'History',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            height: 50,
                            // color: Colors.black,
                          ),
                          Container(
                            height: mediaQuery.screnHeight(context, 2),
                            width: 500,
                            margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: typeCard()
                                  ? baseColor.rmsColor
                                  : baseColor.trrColor,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 30),
                                    child: Text('Transaksi',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 197, 18, 19)))),
                                Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            179, 232, 232, 232),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 70,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          IconlyBold.bag,
                                          color:
                                              Color.fromARGB(255, 197, 18, 19),
                                          size: 28,
                                        ),
                                        title: Text(
                                          'Tropikana Drink',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '17/12/2023',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 15,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          'RP. 20.000.000',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 197, 18, 19)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            179, 232, 232, 232),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 70,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          IconlyBold.bag,
                                          color:
                                              Color.fromARGB(255, 197, 18, 19),
                                          size: 28,
                                        ),
                                        title: Text(
                                          'Tropikana Drink',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '17/12/2023',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 15,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          'RP. 20.000.000',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 197, 18, 19)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            179, 232, 232, 232),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 70,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          IconlyBold.bag,
                                          color:
                                              Color.fromARGB(255, 197, 18, 19),
                                          size: 28,
                                        ),
                                        title: Text(
                                          'Tropikana Drink',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '17/12/2023',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 15,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          'RP. 20.000.000',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 197, 18, 19)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          )
                        ])),
              ],
            ),
          ],
        ));
  }

  bool typeCard() {
    return widget.typeCard == '6';
  }
}
