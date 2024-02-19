part of 'import.dart';

class RamayanaRiwayatIDCashBulan extends StatefulWidget {
  RamayanaRiwayatIDCashBulan({super.key, required this.noMember, required this.month, required this.year});
  final String noMember;
  final String month;
  final String year;
  @override
  State<RamayanaRiwayatIDCashBulan> createState() => _RamayanaRiwayatIDCashBulanState();
}

class _RamayanaRiwayatIDCashBulanState extends State<RamayanaRiwayatIDCashBulan> {
  fetchDataBulan({
    required String nokartu,
    required String bulan,
    required String tahun,
  }) async {
    final Map<String, ApprovalIdcashCustomerTanggal> profileMap = new Map();
    ApprovalIdcashCustomerTanggal.approvalidcashtanggal.clear();
    final responseku = await http.post(Uri.parse('${tipeurl}v1/membercards/tbl_trxsaldokaryawanDD'),
        body: {'nokartu': '${widget.noMember}', 'tahun': '${widget.year}', 'bulan': '${widget.month}'});

    var data = jsonDecode(responseku.body);

    if (data['status'] == 200) {
      print("API Success oooo");
      print(data);
      int count = data['data'].length;
      for (int i = 0; i < count; i++) {
        ApprovalIdcashCustomerTanggal.approvalidcashtanggal.add(ApprovalIdcashCustomerTanggal.fromjson(data['data'][i]));
      }
      // ApprovalIdcashCustomerTanggal.approvalidcashtanggal.forEach((element) {
      //       profileMap[element.tanggal] = element;
      //        ApprovalIdcashCustomerTanggal.approvalidcashtanggal = profileMap.values.toList();
      //      });
      print('check length ${ApprovalIdcashCustomerTanggal.approvalidcashtanggal.length}');
      print(data['data'].toString());
      if (ApprovalIdcashCustomerTanggal.approvalidcashtanggal.length == 0) {
        AlertDialog popup1 = AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          // shadowColor: Colors.black,
          titlePadding: EdgeInsets.all(0),
          title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              height: 170,
              width: 2000,
              child: Image.asset(
                'assets/omaigat.png',
              )),
          content: Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 30,
            child: Center(
              child: Text(
                'Anda tidak memiliki riwayat transaksi',
                style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.start,
          actionsPadding: EdgeInsets.only(bottom: 20),
        );
        showCupertinoModalPopup(context: context, builder: (context) => popup1);
      }
    } else {
      print('NO DATA');
    }

    setState(() {});
  }

  kondisiBulan() {
    var bulan = widget.month;
    if (bulan == '1') {
      return 'Januari';
    } else if (bulan == '2') {
      return 'Februari';
    } else if (bulan == '3') {
      return 'Maret';
    } else if (bulan == '4') {
      return 'April';
    } else if (bulan == '5') {
      return 'Mei';
    } else if (bulan == '6') {
      return 'Juni';
    } else if (bulan == '7') {
      return 'Juli';
    } else if (bulan == '8') {
      return 'Agustus';
    } else if (bulan == '9') {
      return 'September';
    } else if (bulan == '10') {
      return 'Oktober';
    } else if (bulan == '11') {
      return 'November';
    } else if (bulan == '12') {
      return 'Desember';
    } else {
      return bulan;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataBulan(nokartu: '${widget.noMember}', bulan: '${widget.month}', tahun: '${widget.year}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ApprovalIdcash.approvalidcash.removeLast();
            print(ApprovalIdcash.approvalidcash);
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Container(
            margin: EdgeInsets.only(left: 70, right: 70),
            child: Text('Riwayat Transaksi',
                style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.w500)))),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: Stack(fit: StackFit.loose, children: [
        Container(
          color: Color.fromARGB(255, 255, 0, 0),
        ),
        Container(
          margin: EdgeInsets.only(top: 30, left: 5, right: 5, bottom: 10),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: Column(
            children: [
              Center(child: Text('${kondisiBulan()}', style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 20, color: Colors.black)))),
              Container(
                margin: EdgeInsets.only(top: 15, left: 50, right: 50),
                color: Color.fromARGB(255, 197, 197, 197),
                height: 1,
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 105, bottom: 30),
          child: ListView(
            children: ApprovalIdcashCustomerTanggal.approvalidcashtanggal.map(
              (e) {
                print(ApprovalIdcashCustomerTanggal.approvalidcashtanggal.length);
                kondisiSelisih() {
                  var ex = '${e.nilai}';
                  List<String> resultSelisih = ex.split('');
                  print(resultSelisih);
                  if (resultSelisih.length <= 4 && resultSelisih.length > 2) {
                    resultSelisih.insert(resultSelisih.length - 3, '.');
                    print(resultSelisih);
                  } //doneee 1000
                  else if (resultSelisih.length <= 5 && resultSelisih.length > 4) {
                    resultSelisih.insert(resultSelisih.length - 3, '.');
                    print(resultSelisih);
                  } else if (resultSelisih.length <= 6 && resultSelisih.length > 5) {
                    resultSelisih.insert(resultSelisih.length - 3, '.');
                    print(resultSelisih);
                  } else if (resultSelisih.length <= 7 && resultSelisih.length > 6) {
                    resultSelisih.insert(resultSelisih.length - 3, '.');
                    resultSelisih.insert(resultSelisih.length - 7, '.');
                    print(resultSelisih);
                  } else if (resultSelisih.length <= 8 && resultSelisih.length > 7) {
                    resultSelisih.insert(resultSelisih.length - 3, '.');
                    resultSelisih.insert(resultSelisih.length - 7, '.');
                    print(resultSelisih);
                  } else if (resultSelisih.length <= 9 && resultSelisih.length > 8) {
                    resultSelisih.insert(resultSelisih.length - 3, '.');
                    resultSelisih.insert(resultSelisih.length - 7, '.');
                    print(resultSelisih);
                  } else if (resultSelisih.length <= 10 && resultSelisih.length > 9) {
                    resultSelisih.insert(resultSelisih.length - 3, '.');
                    resultSelisih.insert(resultSelisih.length - 7, '.');
                    resultSelisih.insert(resultSelisih.length - 11, '.');
                    print(resultSelisih);
                  } else if (resultSelisih.length <= 11 && resultSelisih.length > 10) {
                    resultSelisih.insert(resultSelisih.length - 3, '.');
                    resultSelisih.insert(resultSelisih.length - 7, '.');
                    resultSelisih.insert(resultSelisih.length - 11, '.');
                    print(resultSelisih);
                  } else if (resultSelisih.length <= 12 && resultSelisih.length > 11) {
                    resultSelisih.insert(resultSelisih.length - 3, '.');
                    resultSelisih.insert(resultSelisih.length - 7, '.');
                    resultSelisih.insert(resultSelisih.length - 11, '.');
                    print(resultSelisih);
                  } else {
                    return e.nilai;
                  }
                  var resultSelisihDone = resultSelisih.join('');
                  return resultSelisihDone;
                }

                return Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  height: 90,
                  child: MaterialButton(
                    onPressed: () {},
                    color: Color.fromARGB(255, 234, 234, 234),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      //                  leading: CircleAvatar(
                      // backgroundColor: Color.fromARGB(255, 255, 17, 17),
                      // child: Icon(Icons.attach_money_outlined, color: Colors.white, size: 25,),
                      //                 ),
                      title: Text('${e.tanggal}', style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 16, color: Colors.black))),
                      subtitle: Text('${e.no_struk}', style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 16, color: Colors.black))),
                      trailing:
                          Text('Rp.${kondisiSelisih()}', style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 16, color: Colors.black))),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        )
      ]),
    );
  }
}
