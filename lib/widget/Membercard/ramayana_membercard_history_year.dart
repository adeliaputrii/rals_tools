part of 'import.dart';

class RamayanaMembercardHistoryY extends StatefulWidget {
  RamayanaMembercardHistoryY(
      {super.key,
      required this.color,
      required this.nokartu,
      required this.typeCard});
  final String color;
  final String nokartu;
  final String typeCard;

  @override
  State<RamayanaMembercardHistoryY> createState() =>
      _RamayanaMembercardHistoryYState();
}

class _RamayanaMembercardHistoryYState
    extends State<RamayanaMembercardHistoryY> {
  late CompanyCardCubit cubit;
  AppWidget appWidget = AppWidget();
  String noKartu = "";

  @override
  void initState() {
    super.initState();

    cubit = context.read<CompanyCardCubit>();
    cubit.getHistoryMemberYear(widget.nokartu);
  }

  Future<void> navigateToHistoryMonth(String year) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RamayanaMembercardHistoryM(
              color: widget.typeCard,
              nokartu: widget.nokartu,
              year: year,
              typeCard: widget.typeCard)),
    );
    if (!mounted) return;
    noKartu = result;
    cubit.getHistoryMemberYear(widget.nokartu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, '${widget.nokartu}');
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 230, 0, 0),
          ),
        ),
        title: Text('Kembali',
            style: GoogleFonts.rubik(
              fontSize: 23,
              color: Color.fromARGB(255, 230, 0, 0),
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Stack(children: [
            Container(
              color: Colors.white,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 40, 20, 30),
                  child: Text('Riwayat Transaksi',
                      style: GoogleFonts.rubik(
                          fontSize: 31,
                          color: getColorForTypePayment(widget.typeCard),
                          fontWeight: FontWeight.w500)),
                ),
                BlocBuilder<CompanyCardCubit, CompanyCardState>(
                    builder: (context, state) {
                  debugPrint('state history is' + state.toString());
                  if (state is CompanyCardLoading) {
                    return Center(child: appWidget.LoadingWidget());
                  }
                  if (state is CompanyCardHistoryYearSuccess) {
                    int lengthData = state.response.data?.length ?? 0;
                    return lengthData != 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: lengthData,
                            itemBuilder: (BuildContext context, int index) {
                              String? totalHarga =
                                  state.response.data?[index].totalHarga;
                              debugPrint(totalHarga);
                              String formattedTotalHarga = totalHarga != null
                                  ? (int.tryParse(totalHarga)?.toIdr() ?? "-")
                                  : "-";
                              debugPrint(formattedTotalHarga);
                              return Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                  decoration: BoxDecoration(
                                      color:getColorForType2( widget.typeCard),
                                      borderRadius: BorderRadius.circular(20)
                                      ),

                                  height: 70,
                                  child: Center(
                                    child: ListTile(
                                      onTap: () {
                                        navigateToHistoryMonth(state.response
                                                .data?[index].datePart ??
                                            '0');
                                      },
                                      leading: Icon(
                                        IconlyBold.bag,
                                        color: widget.typeCard == '6'
                                              ? baseColor.trrColor
                                              : baseColor.primaryColor,
                                        size: 28,
                                      ),
                                      title: Text(
                                        '${state.response.data?[index].datePart ?? '-'}',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                          color: widget.typeCard == '6'
                                              ? baseColor.trrColor
                                              : Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: Text(
                                        '${int.tryParse(state.response.data?[index].totalHarga ?? '0')?.toIdr()}',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: widget.typeCard == '6'
                                              ? baseColor.trrColor
                                              : baseColor.primaryColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ));
                            })
                        : Center(
                          child: Container(
                            color: Colors.amber,
                            child: Text(baseParam.notFoundTransaction,
                                style: GoogleFonts.rubik(
                                    fontSize: 22,
                                    color: getColorForTypePayment(widget.typeCard))),
                          ),
                        );
                  }
                  if (state is CompanyCardFailure) {
                    debugPrint('failed history year');
                    return Container(
                      height: MediaQuery.of(context).size.height - 350,
                      child: Center(
                        child: Text(baseParam.notFoundTransaction,
                            style: GoogleFonts.rubik(
                                fontSize: 16,
                                color: getColorForTypePayment(widget.typeCard))),
                      ),
                    );
                  }
                  return Center(child: appWidget.LoadingWidget());
                }),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
