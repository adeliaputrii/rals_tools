part of 'import.dart';

class RamayanaMembercardHistory extends StatefulWidget {
  RamayanaMembercardHistory(
      {super.key,
      required this.color,
      required this.nokartu,
      required this.year,
      required this.month,
      required this.typeCard});
  final String color;
  final String nokartu;
  final String year;
  final String month;
  final String typeCard;
  static const route = '/ramayana-list-screen';
  @override
  State<RamayanaMembercardHistory> createState() =>
      _RamayanaMembercardHistoryState();
}

class _RamayanaMembercardHistoryState extends State<RamayanaMembercardHistory> {
  late CompanyCardCubit cubit;
  AppWidget appWidget = AppWidget();

  @override
  void initState() {
    super.initState();

    cubit = context.read<CompanyCardCubit>();
    cubit.getHistoryMemberDays(widget.nokartu, widget.year, widget.month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                  margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: Text('Riwayat Transaksi',
                      style: GoogleFonts.rubik(
                          fontSize: 31,
                          color: getColorForTypePayment(widget.typeCard),
                          fontWeight: FontWeight.w500)),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text(getMonthName(widget.month),
                        style: GoogleFonts.rubik(
                            fontSize: 22,
                            color: getColorForTypePayment(widget.typeCard))),
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
                    height: 1,
                    color: getColorForTypePayment(widget.typeCard)),
// ===========================================================================================================================
                Center(
                  child: BlocBuilder<CompanyCardCubit, CompanyCardState>(
                      builder: (context, state) {
                    if (state is CompanyCardLoading) {
                      return appWidget.LoadingWidget();
                    }
                    if (state is CompanyCardHistoryDaySuccess) {
                      int lengthData = state.response.data?.length ?? 0;

                      return lengthData != 0
                          ? listHistory(state.response)
                          : Center(
                              child: Text(baseParam.notFoundTransaction,
                                  style: GoogleFonts.rubik(
                                      fontSize: 22,
                                      color: getColorForTypePayment(widget.typeCard))),
                            );
                    }

                    return appWidget.LoadingWidget();
                  }),
                )
              ],
            ),
          ]),
        ],
      ),
    );
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
                      color: getColorForType2(widget.typeCard),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text(
                          '${historyResponse.data?[index].tanggal ?? '-'}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: widget.typeCard == '6'
                                ? baseColor.trrColor
                                : Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                         color:widget.typeCard == '6'
                                  ? baseColor.trrColor
                                  : baseColor.primaryColor
                      ),
                      Center(
                        child: ListTile(
                          leading: Icon(
                            IconlyBold.bag,
                            color:widget.typeCard == '6'
                                  ? baseColor.trrColor
                                  : baseColor.primaryColor,
                            size: 28,
                          ),
                          title: Text(
                            'ID: ${historyResponse.data?[index].nostruk}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: widget.typeCard == '6'
                                  ? baseColor.trrColor
                                  : Colors.black
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            '${int.tryParse(historyResponse.data?[index].nilai ?? '0')?.toIdr()}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color:widget.typeCard == '6'
                                  ? baseColor.trrColor
                                  : baseColor.primaryColor
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          );
        });
  }
}
