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
  late LoginCubit loginCubit;
  bool isLoading = true;
  AppWidget appWidget = AppWidget();
  final urlApi = '${tipeurl}${basePath.api_login}';

  @override
  void initState() {
    super.initState();
    companyCardCubit = context.read<CompanyCardCubit>();
    idCashCubit = context.read<IDCashCubit>();
    loginCubit = context.read<LoginCubit>();
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
                                      primary:false,
                                        shrinkWrap: true,
                                        itemCount: state.response.data!.length,
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
                                                      state
                                                              .response
                                                              .data?[index]
                                                              .nama ??
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
                                                  loginCubit.createLog(
                                                   baseParam.chooseCard,
                                                   state
                                                   .response
                                                   .data?[index]
                                                   .typeMc ==6
                                                  ?
                                                  baseParam.rmsCard
                                                  :
                                                  baseParam.trrCard
                                                   , urlApi);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return RamayanaMemberCardDetail(
                                                        typeCard: state
                                                                .response
                                                                .data?[index]
                                                                .typeMc
                                                                .toString() ??
                                                            '6',
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
                                                          image: state
                                                                      .response
                                                                      .data?[
                                                                          index]
                                                                      .typeMc ==
                                                                  6
                                                              ? AssetImage(
                                                                  'assets/rms.png')
                                                              : AssetImage(
                                                                  'assets/tropikana.png'),
                                                          fit: BoxFit.fill),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          state
                                                            .response
                                                            .data?[index]
                                                            .typeMc ==6
                                                             ?
                                                             CrossAxisAlignment.start
                                                             :
                                                             CrossAxisAlignment.end,
                                                      children: [
                                                        state
                                                            .response
                                                            .data?[index]
                                                            .typeMc ==6
                                                             ?
                                                              Text(
                                                                  '  ${int.tryParse(state.response.data?[index].saldo ?? '0')?.toIdr() ?? "-"}',
                                                                  style: GoogleFonts.plusJakartaSans(
                                                                      fontSize: 25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white))
                                                             :
                                                             Center(
                                                               child: Text(
                                                                '${int.tryParse(state.response.data?[index].saldo ?? '0')?.toIdr() ?? "-"}',
                                                                style: GoogleFonts.plusJakartaSans(
                                                                    fontSize: 25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white)),
                                                             ),
                                                       
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 10,
                                                                  right: 10,
                                                                  top: 
                                                                  state
                                                            .response
                                                            .data?[index]
                                                            .typeMc ==6
                                                             ?
                                                             50
                                                             :
                                                             10),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                            state
                                                            .response
                                                            .data?[index]
                                                            .typeMc ==6
                                                             ?
                                                             CrossAxisAlignment.start
                                                             :
                                                             CrossAxisAlignment.end,
                                                            children: [
                                                              Text(
                                                                  '  ${state.response.data?[index].nama ?? '-'}',
                                                                  style: GoogleFonts.plusJakartaSans(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                              Text(
                                                                  '  ${state.response.data?[index].nokartu ?? '-'}',
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
}
