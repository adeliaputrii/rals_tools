part of 'import.dart';

class RamayanaMembercardHistoryM extends StatefulWidget {
  const RamayanaMembercardHistoryM(
      {super.key,
      required this.color,
      required this.nokartu,
      required this.year,
      required this.typeCard});
  final bool color;
  final String nokartu;
  final String year;
  final String typeCard;

  @override
  State<RamayanaMembercardHistoryM> createState() =>
      _RamayanaMembercardHistoryMState();
}

class _RamayanaMembercardHistoryMState
    extends State<RamayanaMembercardHistoryM> {
  late CompanyCardCubit cubit;
  AppWidget appWidget = AppWidget();

  @override
  void initState() {
    super.initState();
    cubit = context.read<CompanyCardCubit>();
    cubit.getHistoryMemberMonth(widget.nokartu, widget.year);
  }

  Future<void> navigateToHistoryDays(String month) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RamayanaMembercardHistory(
              color: widget.color,
              nokartu: widget.nokartu,
              year: widget.year,
              month: month,
              typeCard: widget.typeCard)),
    );

    if (!mounted) return;

    cubit.getHistoryMemberMonth(widget.nokartu, widget.year);
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
                          color: widget.color
                              ? Color.fromARGB(255, 197, 18, 19)
                              : Color.fromARGB(255, 82, 74, 156),
                          fontWeight: FontWeight.w500)),
                ),
                BlocBuilder<CompanyCardCubit, CompanyCardState>(
                    builder: (context, state) {
                  if (state is CompanyCardLoading) {
                    return Center(child: appWidget.LoadingWidget());
                  }
                  if (state is CompanyCardHistoryMonthSuccess) {
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
                                      color: widget.color
                                          ? Color.fromARGB(255, 190, 215, 44)
                                          : Color.fromARGB(255, 255, 207, 228),
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 70,
                                  child: Center(
                                    child: ListTile(
                                      onTap: () {
                                        navigateToHistoryDays(
                                            state.response.data?[index].month ??
                                                '');
                                      },
                                      leading: Icon(
                                        IconlyBold.bag,
                                        color: widget.color
                                            ? Color.fromARGB(255, 197, 18, 19)
                                            : Color.fromARGB(255, 82, 74, 156),
                                        size: 28,
                                      ),
                                      title: Text(
                                        '${getMonthName(state.response.data?[index].month ?? '0') ?? '-'}',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: widget.color
                                              ? Colors.black
                                              : Color.fromARGB(
                                                  255, 82, 74, 156),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: Text(
                                        '${int.tryParse(state.response.data?[index].totalHarga ?? '0')?.toIdr()}',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: widget.color
                                              ? Color.fromARGB(255, 197, 18, 19)
                                              : Color.fromARGB(
                                                  255, 82, 74, 156),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ));
                            })
                        : Center(
                          child: Text(baseParam.notFoundTransaction,
                              style: GoogleFonts.rubik(
                                  fontSize: 22,
                                  color: typeCard(widget.typeCard)
                                      ? Color.fromARGB(255, 197, 18, 19)
                                      : Color.fromARGB(255, 82, 74, 156))),
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

String getMonthName(String monthNum) {
  List<String> monthName = [
    '',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  var month = "";
  int? monthNumber = int.tryParse(monthNum);
  for (int i = 0; i <= monthNumber!; i++) {
    month = monthName[i];
  }
  return month;
}
