part of 'import.dart';

class RamayanaRiwayatIDCash extends StatefulWidget {
  RamayanaRiwayatIDCash({super.key, required this.noMember});
  final String noMember;

  @override
  State<RamayanaRiwayatIDCash> createState() => _RamayanaRiwayatIDCashState();
}

class _RamayanaRiwayatIDCashState extends State<RamayanaRiwayatIDCash> {
  UserData userData = UserData();

  fetchDataTahun({
    required String nokartu,
  }) async {
    final Map<String, ApprovalIdcashCustomerTahun> profileMap = new Map();
    ApprovalIdcashCustomerTahun.approvalidcashtahun.clear();
    final responseku = await http.post(
        Uri.parse('${tipeurl}v1/membercards/tbl_trxsaldokaryawanYY'),
        body: {
          'nokartu': '${widget.noMember}'
          // 'nokartu' : '1100180309385576'
        });
    var data = jsonDecode(responseku.body);

    if (data['status'] == 200) {
      print("API Success oooo");
      print(data);
      int count = data['data'].length;
      for (int i = 0; i < count; i++) {
        ApprovalIdcashCustomerTahun.approvalidcashtahun
            .add(ApprovalIdcashCustomerTahun.fromjson(data['data'][i]));
      }
      // ApprovalIdcashCustomerTahun.approvalidcashtahun.forEach((element) {
      //   profileMap[element.tahun] = element;
      //    ApprovalIdcashCustomerTahun.approvalidcashtahun = profileMap.values.toList();
      //  });
      print(
          'check length ${ApprovalIdcashCustomerTahun.approvalidcashtahun.length}');
      print(data['data'].toString());
      if (ApprovalIdcashCustomerTahun.approvalidcashtahun.length == 0) {
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
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
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

  @override
  void didPushNext() {
    ScreenBrightness().resetScreenBrightness();
  }

  @override
  void didPop() {
    ScreenBrightness().resetScreenBrightness();
  }

  @override
  void initState() {
    super.initState();
    didPop();
    didPushNext();
    fetchDataTahun(nokartu: '${widget.noMember}');
    // fetchDataTahun(nokartu: '1100180309385576');
  }

  var selected2;
  final List<String> data2 = ['RB17', 'R136', 'S204', 'S445'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return RamayanaIDCash();
            }), (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios,
              color: Colors.white,),
        ),
        title: Container(
            margin: EdgeInsets.only(left: 70, right: 70),
            child: Text('Riwayat Transaksi',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)))),
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
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Tahun',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ))),
                  Text('Total',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ))),
                ],
              ),
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
            children: ApprovalIdcashCustomerTahun.approvalidcashtahun.map((e) {
              kondisiSelisih() {
                var ex = '${e.nilai}';
                List<String> resultSelisih = ex.split('');
                print(resultSelisih);
                if (resultSelisih.length <= 4 && resultSelisih.length > 2) {
                  resultSelisih.insert(resultSelisih.length - 3, '.');
                  print(resultSelisih);
                } //doneee 1000
                else if (resultSelisih.length <= 5 &&
                    resultSelisih.length > 4) {
                  resultSelisih.insert(resultSelisih.length - 3, '.');
                  print(resultSelisih);
                } else if (resultSelisih.length <= 6 &&
                    resultSelisih.length > 5) {
                  resultSelisih.insert(resultSelisih.length - 3, '.');
                  print(resultSelisih);
                } else if (resultSelisih.length <= 7 &&
                    resultSelisih.length > 6) {
                  resultSelisih.insert(resultSelisih.length - 3, '.');
                  resultSelisih.insert(resultSelisih.length - 7, '.');
                  print(resultSelisih);
                } else if (resultSelisih.length <= 8 &&
                    resultSelisih.length > 7) {
                  resultSelisih.insert(resultSelisih.length - 3, '.');
                  resultSelisih.insert(resultSelisih.length - 7, '.');
                  print(resultSelisih);
                } else if (resultSelisih.length <= 9 &&
                    resultSelisih.length > 8) {
                  resultSelisih.insert(resultSelisih.length - 3, '.');
                  resultSelisih.insert(resultSelisih.length - 7, '.');
                  print(resultSelisih);
                } else if (resultSelisih.length <= 10 &&
                    resultSelisih.length > 9) {
                  resultSelisih.insert(resultSelisih.length - 3, '.');
                  resultSelisih.insert(resultSelisih.length - 7, '.');
                  resultSelisih.insert(resultSelisih.length - 11, '.');
                  print(resultSelisih);
                } else if (resultSelisih.length <= 11 &&
                    resultSelisih.length > 10) {
                  resultSelisih.insert(resultSelisih.length - 3, '.');
                  resultSelisih.insert(resultSelisih.length - 7, '.');
                  resultSelisih.insert(resultSelisih.length - 11, '.');
                  print(resultSelisih);
                } else if (resultSelisih.length <= 12 &&
                    resultSelisih.length > 11) {
                  resultSelisih.insert(resultSelisih.length - 3, '.');
                  resultSelisih.insert(resultSelisih.length - 7, '.');
                  resultSelisih.insert(resultSelisih.length - 11, '.');
                  print(resultSelisih);
                } else {
                  return e.nilai;
                }
                var resultSelisihDone = resultSelisih.join('');
                return resultSelisihDone;
                // if(resultSelisih.length <= 6 && resultSelisih.length > 5)
                // {
                //   print('true');
                // } else {
                //   print('false');
                // }
              }

              print(kondisiSelisih());

              return Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                height: 90,
                child: MaterialButton(
                  onPressed: () {
                    ApprovalIdcash.approvalidcash.add(e.tahun);
                    print(ApprovalIdcash.approvalidcash);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RamayanaRiwayatIDCash2(
                        noMember: widget.noMember,
                        year: e.tahun,
                      );
                    }));
                  },
                  color: Color.fromARGB(255, 234, 234, 234),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 255, 17, 17),
                      child: Icon(
                        Icons.attach_money_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    title: Text(
                      '${e.tahun}',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                    ),
                    trailing: Text(
                      'Rp. ${kondisiSelisih()}',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ]),
    );
  }
}
