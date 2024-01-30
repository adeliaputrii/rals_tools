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
  String cardNumber = "";
  late CompanyCardCubit cubit;
  late LoginCubit loginCubit;
  AppWidget appWidget = AppWidget();
  var balance = 0;
  List<DataHistory> historyResponse = [];
  final urlApi = '${tipeurl}${basePath.api_login}';
  @override
  void initState() {
    super.initState;

    cubit = context.read<CompanyCardCubit>();
    cardNumber = widget.data.nokartu ?? '';
    loginCubit = context.read<LoginCubit>();
    cubit.getDetailCard(cardNumber);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> navigateToHistoryYear() async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    debugPrint('navigator push');
    loginCubit.createLog(
        typeCard(widget.typeCard)
            ? baseParam.rmsCardPage
            : baseParam.trrCardPage,
        baseParam.navigateHistory,
        urlApi);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RamayanaMembercardHistoryY(
              color: typeCard(widget.typeCard) ? true : false,
              nokartu: cardNumber,
              typeCard: widget.typeCard)),
    );
    debugPrint('navigator pop');
    if (!mounted) return;

    cubit.getDetailCard('$result');
    cubit.getHistoryMember('$result');
    FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    ScreenBrightness().resetScreenBrightness();
  }

  Future<void> navigateToPayment() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RamayanaMembercardQr(
              icon: typeCard(widget.typeCard), nokartu: cardNumber)),
    );
    loginCubit.createLog(
        typeCard(widget.typeCard)
            ? baseParam.rmsCardPage
            : baseParam.trrCardPage,
        baseParam.navigatePayment,
        urlApi);
    if (!mounted) return;

    cubit.getDetailCard('$result');
    cubit.getHistoryMember('$result');
    FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    ScreenBrightness().resetScreenBrightness();
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
          title: Text('Kartu Tambahan',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 23, color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 210, 14, 0),
          elevation: 0,
          toolbarHeight: 80,
        ),
        body: BlocListener<CompanyCardCubit, CompanyCardState>(
            listener: (context, state) {
          if (state is CompanyCardDetailSuccess) {
            final saldo =
                (int.tryParse(state.response.data?.first.saldo ?? '0') ?? 0);
            final pemakaian =
                (int.tryParse(state.response.data?.first.pemakaian ?? '0') ??
                    0);

            balance = saldo - pemakaian;

            cubit.getHistoryMember(cardNumber);
          }
          if (state is CompanyCardHistorySuccess) {
            state.response.data?.forEach((element) {
              historyResponse.add(element);
            });
          }
        }, child: BlocBuilder<CompanyCardCubit, CompanyCardState>(
                builder: (context, state) {
          debugPrint('state is' + state.toString());
          if (state is CompanyCardLoading) {
            return appWidget.LoadingWidget();
          }

          if (state is CompanyCardHistorySuccess) {
            return ListView(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FlipCard(
                              fill: Fill
                                  .fillBack, // Fill the back side of the card to make in the same size as the front.
                              direction: FlipDirection.HORIZONTAL, // default
                              side: CardSide
                                  .FRONT, // The side to initially display.
                              front: Center(
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
                                          image: typeCard(widget.typeCard)
                                              ? AssetImage('assets/rms.png')
                                              : AssetImage(
                                                  'assets/tropikana.png'),
                                          fit: BoxFit.fill),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          typeCard(widget.typeCard)
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: typeCard(widget.typeCard)
                                                  ? 130
                                                  : 160),
                                          child: Center(
                                            child: Text('${balance.toIdr()}',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        fontSize: 28,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                          ),
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
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                          fontSize: 16,
                                                          color: Colors.white)),
                                              Text('${widget.data.nokartu}',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
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
                              back: Center(
                                child: Container(
                                  key: ValueKey(1),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Container(
                                      width: 700,
                                      height: 280,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 235, 227, 227),
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
                                            image: typeCard(widget.typeCard)
                                                ? AssetImage('assets/rms.png')
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
                                                    value:
                                                        '${widget.data.nokartu}',
                                                    backgroundColor:
                                                        Colors.white,
                                                    barColor: Colors.black,
                                                    symbology: Code128())),
                                          ))),
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 0, right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    navigateToPayment();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 190,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: typeCard(widget.typeCard)
                                          ? baseColor.primaryColor
                                          : baseColor.trrColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/qr.png'),
                                        Text(
                                          'Pembayaran',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    navigateToHistoryYear();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 190,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: typeCard(widget.typeCard)
                                          ? baseColor.rmsColor
                                          : baseColor.trrColorPink,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/history.png',
                                        ),
                                        Text(
                                          'Riwayat',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            height: 50,
                            // color: Colors.black,
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 35, bottom: 30),
                              child: Text('Transaksi Terakhir',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: typeCard(widget.typeCard)
                                        ? baseColor.primaryColor
                                        : baseColor.trrColor,
                                  ))),
                          state.response.data?.length != 0
                              ? listHistory(state.response)
                              : Text(baseParam.notFoundTransaction,
                                  style: GoogleFonts.rubik(
                                      fontSize: 16,
                                      color: typeCard(widget.typeCard)
                                          ? Color.fromARGB(255, 197, 18, 19)
                                          : Color.fromARGB(255, 82, 74, 156)))
                        ])),
              ],
            );
          }
          if (state is CompanyCardFailure) {
            return ListView(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FlipCard(
                              fill: Fill
                                  .fillBack, // Fill the back side of the card to make in the same size as the front.
                              direction: FlipDirection.HORIZONTAL, // default
                              side: CardSide
                                  .FRONT, // The side to initially display.
                              front: Center(
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
                                          image: typeCard(widget.typeCard)
                                              ? AssetImage('assets/rms.png')
                                              : AssetImage(
                                                  'assets/tropikana.png'),
                                          fit: BoxFit.fill),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          typeCard(widget.typeCard)
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: typeCard(widget.typeCard)
                                                  ? 130
                                                  : 160),
                                          child: Center(
                                            child: Text('${balance.toIdr()}',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        fontSize: 28,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                          ),
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
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                          fontSize: 16,
                                                          color: Colors.white)),
                                              Text('${widget.data.nokartu}',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
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
                              back: Center(
                                child: Container(
                                  key: ValueKey(1),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Container(
                                      width: 700,
                                      height: 280,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 235, 227, 227),
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
                                            image: typeCard(widget.typeCard)
                                                ? AssetImage('assets/rms.png')
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
                                                    value:
                                                        '${widget.data.nokartu}',
                                                    backgroundColor:
                                                        Colors.white,
                                                    barColor: Colors.black,
                                                    symbology: Code128())),
                                          ))),
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 0, right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    navigateToPayment();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 190,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: typeCard(widget.typeCard)
                                          ? baseColor.primaryColor
                                          : baseColor.trrColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/qr.png'),
                                        Text(
                                          'Pembayaran',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    navigateToHistoryYear();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 190,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: typeCard(widget.typeCard)
                                          ? baseColor.rmsColor
                                          : baseColor.trrColorPink,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/history.png',
                                        ),
                                        Text(
                                          'Riwayat',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            height: 50,
                            // color: Colors.black,
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 35, bottom: 30),
                              child: Text('Transaksi Terakhir',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: typeCard(widget.typeCard)
                                        ? baseColor.primaryColor
                                        : baseColor.trrColor,
                                  ))),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(baseParam.notFoundTransaction,
                                style: GoogleFonts.rubik(
                                    fontSize: 18,
                                    color: typeCard(widget.typeCard)
                                        ? Color.fromARGB(255, 197, 18, 19)
                                        : Color.fromARGB(255, 82, 74, 156))),
                          )
                        ])),
              ],
            );
          }
          return appWidget.LoadingWidget();
        })));
  }

  Widget listHistory(CompanyCardHistoryResponse historyResponse) {
    return ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: historyResponse.data?.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  decoration: BoxDecoration(
                      color: typeCard(widget.typeCard)
                          ? Color.fromARGB(255, 190, 215, 44)
                          : Color.fromARGB(255, 255, 207, 228),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text(
                          'ID: ${historyResponse.data?[index].notrx ?? '-'}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: typeCard(widget.typeCard)
                                ? Colors.black
                                : baseColor.trrColor,
                          ),
                        ),
                        trailing: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: typeCard(widget.typeCard)
                                ? baseColor.primaryColor
                                : baseColor.trrColor,
                          ),
                          child: Center(
                            child: Text(
                              '${historyResponse.data?[index].poin ?? '-'} Poin',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: typeCard(widget.typeCard)
                            ? baseColor.primaryColor
                            : baseColor.trrColor,
                      ),
                      Center(
                        child: ListTile(
                          leading: Icon(
                            IconlyBold.bag,
                            color: typeCard(widget.typeCard)
                                ? Color.fromARGB(255, 197, 18, 19)
                                : Color.fromARGB(255, 82, 74, 156),
                            size: 28,
                          ),
                          title: Text(
                            typeTransaction(
                                historyResponse.data?[index].type ?? ''),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: typeCard(widget.typeCard)
                                  ? Colors.black
                                  : Color.fromARGB(255, 82, 74, 156),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            '${int.tryParse(historyResponse.data?[index].totalHarga ?? '0')?.toIdr()}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: typeCard(widget.typeCard)
                                  ? Color.fromARGB(255, 197, 18, 19)
                                  : Color.fromARGB(255, 82, 74, 156),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          '${(historyResponse.data?[index].createdDate)?.formatDate()}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            color: typeCard(widget.typeCard)
                                ? Colors.black
                                : baseColor.trrColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )),
            ],
          );
        });
  }
}

String typeTransaction(String type) {
  String description = "";
  if (type == 'A') {
    description = baseParam.typeA;
  }
  if (type == 'P') {
    description = baseParam.typeP;
  }
  if (type == 'T') {
    description = baseParam.typeA;
  }
  if (type == 'C') {
    description = baseParam.typeP;
  }
  if (type == 'S') {
    description = baseParam.typeA;
  }
  if (type == 'B') {
    description = baseParam.typeP;
  }
  if (type == 'J') {
    description = baseParam.typeA;
  }
  if (type == 'V') {
    description = baseParam.typeP;
  }

  return description;
}

bool typeCard(typeCard) {
  return typeCard == '6';
}
