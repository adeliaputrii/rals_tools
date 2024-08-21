import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myactivity_project/cubit/stock_opname/so_cubit.dart';
import 'package:myactivity_project/data/model/stock_opname_submit_body.dart';
import 'package:myactivity_project/database/StockOpname/db_get_data.dart';
import 'package:myactivity_project/database/StockOpname/db_save_data.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';
import 'package:myactivity_project/utils/app_widgets.dart';
import 'package:myactivity_project/utils/popup_widget.dart';
import 'package:myactivity_project/widget/Stock%20Opname/import.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoPopup extends StatefulWidget {
  const SoPopup({super.key});

  @override
  State<SoPopup> createState() => _SoPopupState();
}

class _SoPopupState extends State<SoPopup> {
  DbSoGetData db = DbSoGetData();
  DbSoSaveData dbSave = DbSoSaveData();
  UserData userData = UserData();
  List<Data> dataItems = [];
  final List<StockOpnameBody> dataList = [];
  late StockOpnameCubit soCubit;
  late PopUpWidget popUpWidget;

  bool connection = false;
  List? listDbSave;
  String? token;
  String message = 'Success';
  String selectLocationText = 'Select Location';
  String textSubmit = 'SUBMIT';

  @override
  void initState() {
    refreshpage();
    super.initState();
    soCubit = context.read<StockOpnameCubit>();
    popUpWidget = PopUpWidget(context);
  }

  refreshpage() async {
    internetCheck();
    getDatabaseSave();
    getDatabase();
    parameter();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    token = await SharedPref.getToken();
  }

  Future getDatabase() async {
    try {
      return await db.getAllFormat();
    } catch (e) {
      print('Error fetching data: $e');
      return;
    }
  }

  Future getDatabaseSave() async {
    try {
      listDbSave = await dbSave.getAllFormat();
      print('listDbSave ${listDbSave}');
      return listDbSave;
    } catch (e) {
      print('Error fetching data: $e');
      return;
    }
  }

  internetCheck() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          connection = false;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        connection = true;
      });
    }
  }

  parameter() {
    Map<String, String> storeInfo = {
      "username7": '${userData.getUsername7()}',
      "toko": '${userData.getUserToko()}'
    };
    print(storeInfo);
    String jsonString = jsonEncode(storeInfo);
    // Mengonversi string menjadi bytes
    Uint8List bytes = utf8.encode(jsonString);
    // Meng-encode bytes menjadi string Base64
    String base64String = base64Encode(bytes);
    print("Encoded: $base64String");
    return base64String;
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titlePadding: EdgeInsets.all(5),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        width: 500,
        child: Image.asset(
          'assets/location.png',
          height: 180,
        )
      ),
      content: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 120,
        child: Column(
          children: [
            Text(
              '${selectLocationText}',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            connection
            ? FutureBuilder<dynamic>(
            future: getDatabase(),
            builder: (context, snapshot) {
            print('listDbSave ${listDbSave}');
            List data = snapshot.data;
            if (data.isNotEmpty) {
              return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
                minWidth: screenWidth,
                height: 40,
                color: Colors.green,
                onPressed: () {
                  var posLocation = '${data?[0]['pos']}-${data?[0]['location']}';
                  Navigator.pop(context, {
                  'location': '${data?[0]['location']}',
                  'pos': '${data?[0]['pos']}',
                  'date': '${data?[0]['tanggal']}',
                  'posLocation': '${posLocation}',
                  'id': data[0]['id']
                  });
                  },
                  child: Text('${data?[0]['pos']}-${data?[0]['location']}',
                   style: GoogleFonts.plusJakartaSans(
                    fontSize: 18, 
                    color: Colors.white),
                   )),
                  );
                  } else {
                    if (listDbSave!.isEmpty) {
                      return Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'No Internet Connection',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15, 
                          color: Colors.black
                        ),
                      ),
                    );
                    }else {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          selectLocationText =
                          'Kirim data lokal ke database?';
                        });
                      });
                    return Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                      'Hubungkan dengan jaringan Ramayana!!!',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15, 
                        color: Colors.black
                      ),
                    ),
                  );
                }
              }
              })
              : listDbSave!.isEmpty
                ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: BlocBuilder<StockOpnameCubit, StockOpnameState>(
                  builder: (context, state) {
                    print('state is ${state}');
                    if (state is StockOpnameLoading) {
                    // return AppWidget().LoadingWidget();
                    }
                    if (state is StockOpnameSubmitSuccess) {
                      setState(() {
                        message = '${state.response.message}';
                      });
                    }
                    if (state is StockOpnameSubmitFailure) {
                      setState(() {
                        message = '${state.message}';
                      });
                    }
                    if (state is StockOpnameFailure) {
                      return Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                        '${state.message}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15, 
                          color: Colors.black
                        ),
                      ),
                      );
                    }
                    if (state is StockOpnameSuccess) {
                      if (state.response.data!.isEmpty) {
                        print('DATA NULL');
                        return Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                          'No Data Available',
                           style: GoogleFonts.plusJakartaSans(
                              fontSize: 15, 
                              color: Colors.black
                            ),
                          ),
                        );
                      } else {
                        return MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(10)),
                            minWidth: screenWidth,
                            height: 40,
                            color: Colors.green,
                            onPressed: () {
                              var posLocation = '${state.response.data?.first.pos}-${state.response.data?.first.lokasi}';
                              Navigator.pop(context, {
                                'location':'${state.response.data?.first.lokasi}',
                                'pos':'${state.response.data?.first.pos}',
                                'date':'${state.response.data?.first.tanggal}',
                                'posLocation': '${posLocation}',
                              });
                            },
                            child: Text('${state.response.data?.first.pos}-${state.response.data?.first.lokasi}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 18, 
                                color: Colors.white
                              ),
                            ));
                          }
                        }
                        return Container();
                      }
                    ),
                  )
                : FutureBuilder<dynamic>(
                  future: getDatabaseSave(),
                  builder: (context, snapshot) {
                  print('listDbSave ${listDbSave}');
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      selectLocationText = 'Kirim data lokal ke database?';
                    });
                  });
                  List data = snapshot.data;
                  if (data != null) {
                    dataItems = data!.map((item) {
                    return Data(
                      sku: item['sku'], 
                      qty: item['quantity']
                    );
                    }).toList();
                  }
                  return BlocListener<StockOpnameCubit, StockOpnameState>(
                  listener: (context, state) {
                    if (state is StockOpnameSubmitFailure) {
                      Navigator.pop(context);
                      popUpWidget.showPopUpWarning('${state.message}', 'OK');
                      return;
                    }
                    if (state is StockOpnameSubmitSuccess) {
                      Navigator.pop(context);
                      dbSave.deleteAll();
                      popUpWidget.showPopupSucces('${state.response.message}');
                      return;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(10)
                      ),
                      minWidth: screenWidth,
                      height: 40,
                      color: Colors.green,
                      onPressed: () async {
                        for (var activity in listDbSave!) {
                          var parsedData = activity['data'];
                            if (parsedData is String) {
                              parsedData = jsonDecode(parsedData); 
                            }
                          dataList.add(
                            StockOpnameBody(
                              pos: activity['pos'],
                              lokasi: activity['location'],
                              tanggal: activity['tanggal'],
                              data: (parsedData as List).map((item) {
                                return Data(
                                  sku: item['sku'],
                                  qty: item['qty'],
                                );
                              }).toList(),
                            ),
                          );
                        }
                        final requestBody = StockOpnameSubmitBody(
                        quenic: '${parameter()}',
                        data: dataList);
                        setState(() async {
                          print('DATAA body: ${requestBody.toJson()}');
                          soCubit.postResult(token ?? '', requestBody);
                        });
                      },
                      child: Text('SUBMIT',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18, 
                          color: Colors.white
                        ),
                      )),
                    ),
                  );
                })
            ],
          )),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    ;
  }
}
