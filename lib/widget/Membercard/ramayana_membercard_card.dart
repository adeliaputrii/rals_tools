part of 'import.dart';

class RamayanaMembercardCard extends StatefulWidget {
  const RamayanaMembercardCard({super.key});

  @override
  State<RamayanaMembercardCard> createState() => _RamayanaMembercardCardState();
}

class _RamayanaMembercardCardState extends State<RamayanaMembercardCard> {
  UserData userData = UserData();
  late CompanyCardCubit companyCardCubit;
  late IDCashCubit idCashCubit;
  bool isLoading = true;
  AppWidget appWidget = AppWidget();

  @override
  void initState() {
    super.initState();
    companyCardCubit = context.read<CompanyCardCubit>();
    idCashCubit = context.read<IDCashCubit>();
    getUserCard();
  }

  Future<void> getUserCard() async {
    final userID = await SharedPref.getUserId();
    final body = DataMemberCardBody(idUser: userID);
    idCashCubit.getDataMember(body);
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                      builder: (context) => RamayanaMembercardAuthentication()),
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
          toolbarHeight: 80,
        ),
        body: BlocListener<IDCashCubit, IDCashState>(
            listener: (context, state) {
              if (state is IDCashSuccess) {
                setState(() {
                  isLoading = false;
                });
                companyCardCubit
                    .getDataMember(state.response.data?.first.nokartu ?? '0');
              }
            },
            child: isLoading
                ? appWidget.LoadingWidget()
                : BlocBuilder<CompanyCardCubit, CompanyCardState>(
                    builder: (context, state) {
                      if (state is CompanyCardLoading) {
                        return appWidget.LoadingWidget();
                      }
                      if (state is CompanyCardSuccess) {
                        List<ResponseCompany.DataCompany> cardActive = [];
                        DateTime currentDay = DateTime.now();
                        state.response.data?.forEach((element) {
                          DateTime parsedDate = DateTime.parse(
                              element.tglinaktif ?? '2023-01-01');
                          if (element.status == 1 &&
                              currentDay.isBefore(parsedDate)) {
                            cardActive.add(element);
                          }
                        });
                        return ListView(
                          children: [
                            Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Center(
                                        child: Text('Pilih Kartu',
                                            style: GoogleFonts.plusJakartaSans(
                                                fontSize: 26,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                      ),
                                    ),
                                    ListView.builder(
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: cardActive.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 30,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                      cardActive[index].nama ??
                                                          '-',
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              fontSize: 20,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  210,
                                                                  14,
                                                                  0))),
                                                ),
                                              ),
                                              MaterialButton(
                                                onPressed: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return RamayanaMemberCardDetail(
                                                        typeCard: state
                                                                .response
                                                                .data?[index]
                                                                .typeMc
                                                                .toString() ??
                                                            '7',
                                                        data: state.response
                                                            .data![index]);
                                                  }));
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      20, 20, 20, 0),
                                                  child: Container(
                                                    width: 700,
                                                    height: 280,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 235, 227, 227),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        bottomRight:
                                                            Radius.circular(20),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    136,
                                                                    131,
                                                                    131),
                                                            spreadRadius: 2,
                                                            blurRadius: 5,
                                                            offset:
                                                                Offset(2, 4))
                                                      ],
                                                      image: DecorationImage(
                                                          image: typeCard(state.response.data?[index].typeMc)
                                                              ? AssetImage(
                                                                  'assets/tropikana.png')
                                                              : AssetImage(
                                                                  'assets/rms.png'),
                                                          fit: BoxFit.fill),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment: state
                                                                  .response
                                                                  .data?[index]
                                                                  .typeMc ==
                                                              7
                                                          ? CrossAxisAlignment
                                                              .start
                                                          : CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        typeCard(state.response.data?[index].typeMc)
                                                            ? Text(
                                                                totalBalance(
                                                                  int.tryParse(state
                                                                              .response
                                                                              .data?[index]
                                                                              .saldo ??
                                                                          '0') ??
                                                                      0,
                                                                  int.tryParse(state
                                                                              .response
                                                                              .data?[index]
                                                                              .pemakaian ??
                                                                          '0') ??
                                                                      0,
                                                                ),
                                                                style: GoogleFonts.plusJakartaSans(
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white))
                                                            : Center(
                                                                child: Text(
                                                                    totalBalance(
                                                                      int.tryParse(cardActive[index].saldo ??
                                                                              '0') ??
                                                                          0,
                                                                      int.tryParse(cardActive[index].pemakaian ??
                                                                              '0') ??
                                                                          0,
                                                                    ),
                                                                    style: GoogleFonts.plusJakartaSans(
                                                                        fontSize:
                                                                            25,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              bottom: 10,
                                                              right: 10,
                                                              top: typeCard(state.response.data?[index].typeMc)
                                                                  ? 50
                                                                  : 10),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment: typeCard(state.response.data?[index].typeMc)
                                                                ? CrossAxisAlignment
                                                                    .start
                                                                : CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                  '  ${cardActive[index].nama ?? '-'}',
                                                                  style: GoogleFonts.plusJakartaSans(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                              Text(
                                                                  '  ${cardActive[index].nokartu ?? '-'}',
                                                                  style: GoogleFonts.plusJakartaSans(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        })
                                  ],
                                )
                              ],
                            ),
                          ],
                        );
                      }

                      return Container();
                    },
                  )));
  }

  String totalBalance(int saldo, int pemakaian) {
    final balance = saldo - pemakaian;
    return balance.toIdr();
  }
}
