part of 'import.dart';

class RamayanaMembercardHistory extends StatefulWidget {
  RamayanaMembercardHistory(
      {super.key,
      required this.color,
      required this.nokartu,
      required this.year,
      required this.month,
      required this.typeCard});
  final bool color;
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
                          color: typeCard(widget.typeCard)
                              ? Color.fromARGB(255, 197, 18, 19)
                              : Color.fromARGB(255, 82, 74, 156),
                          fontWeight: FontWeight.w500)),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text(getMonthName(widget.month),
                        style: GoogleFonts.rubik(
                            fontSize: 22,
                            color: typeCard(widget.typeCard)
                                ? Color.fromARGB(255, 197, 18, 19)
                                : Color.fromARGB(255, 82, 74, 156))),
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
                    height: 1,
                    color: typeCard(widget.typeCard)
                        ? Color.fromARGB(255, 197, 18, 19)
                        : Color.fromARGB(255, 82, 74, 156)),
// ===========================================================================================================================
                BlocBuilder<CompanyCardCubit, CompanyCardState>(
                    builder: (context, state) {
                  if (state is CompanyCardLoading) {
                    return appWidget.LoadingWidget();
                  }
                  if (state is CompanyCardHistoryDaySuccess) {
                    int lengthData = state.response.data?.length ?? 0;

                    return lengthData != 0
                        ? listHistory(state.response)
                        : Text(baseParam.notFoundTransaction,
                            style: GoogleFonts.rubik(
                                fontSize: 22,
                                color: typeCard(widget.typeCard)
                                    ? Color.fromARGB(255, 197, 18, 19)
                                    : Color.fromARGB(255, 82, 74, 156)));
                  }

                  return appWidget.LoadingWidget();
                })
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
                            fontSize: 16,
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