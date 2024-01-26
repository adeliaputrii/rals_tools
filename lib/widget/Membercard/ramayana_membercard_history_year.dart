part of 'import.dart';

class RamayanaMembercardHistoryY extends StatefulWidget {
  RamayanaMembercardHistoryY(
      {super.key, required this.color, required this.nokartu});
  final bool color;
  final String nokartu;

  @override
  State<RamayanaMembercardHistoryY> createState() =>
      _RamayanaMembercardHistoryYState();
}

class _RamayanaMembercardHistoryYState
    extends State<RamayanaMembercardHistoryY> {
  late CompanyCardCubit cubit;
  AppWidget appWidget = AppWidget();

  @override
  void initState() {
    super.initState();

    cubit = context.read<CompanyCardCubit>();
    cubit.getHistoryMemberYear(widget.nokartu);
  }

  Future<void> navigateToHistoryMonth(String year) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    debugPrint('navigator push');
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RamayanaMembercardHistoryM(
              color: widget.color, nokartu: widget.nokartu, year: year)),
    );
    debugPrint('navigator pop' + result);
    if (!mounted) return;

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
                  if (state is CompanyCardHistoryYearSuccess) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.response.data!.length,
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
                                    navigateToHistoryMonth(
                                        state.response.data?[index].datePart ??
                                            '0');
                                  },
                                  leading: Icon(
                                    IconlyBold.bag,
                                    color: widget.color
                                        ? Color.fromARGB(255, 197, 18, 19)
                                        : Color.fromARGB(255, 82, 74, 156),
                                    size: 28,
                                  ),
                                  title: Text(
                                    '${state.response.data?[index].datePart ?? '-'}',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: widget.color
                                          ? Colors.black
                                          : Color.fromARGB(255, 82, 74, 156),
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
                                          : Color.fromARGB(255, 82, 74, 156),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ));
                        });
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
