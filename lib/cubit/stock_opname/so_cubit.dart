import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myactivity_project/data/model/stock_opname_body.dart';
import 'package:myactivity_project/data/model/stock_opname_list_response.dart';
import 'package:myactivity_project/data/model/stock_opname_response.dart';
import 'package:myactivity_project/data/model/stock_opname_submit_body.dart';
import 'package:myactivity_project/data/model/stock_opname_submit_reponse.dart';
import 'package:myactivity_project/data/repository/stock_opname_repository.dart';
import 'package:myactivity_project/database/StockOpname/db_get_data.dart';
import 'package:myactivity_project/database/StockOpname/db_save_data.dart';
import 'package:myactivity_project/models/StockOpname/model_getData.dart';


part 'so_state.dart';

class  StockOpnameCubit extends Cubit< StockOpnameState> {
   StockOpnameCubit() : super( StockOpnameInitial());

  final  StockOpnameRepositories repositories =  StockOpnameRepositories();

  final _repo =  StockOpnameRepositories();
  DbSoGetData db = DbSoGetData();
  DbSoSaveData dbSave = DbSoSaveData();

  void getPosLocation(
    String token, StockOpnameGetBody body
    ) async {
    emit( StockOpnameLoading());
    try {
      await repositories.getPosLocation(
        token, body
        ).then((value) async {
        if (value!.isSuccess && value.dataResponse is  StockOpnameResponse) {
          final res = value.dataResponse as  StockOpnameResponse;
        //   List? existingData = await db.getAllFormat();
        //   List<String> existingPos = existingData!.map((e) => e['columnLocation'] as String).toList();
        //   for (var item in res.data!) {
        //   if (!existingPos.contains(item.lokasi)) {
        //    debugPrint('${item.lokasi}');
        //     db.save(SoGetDataModel(
        //       pos: item.pos,
        //       location: item.lokasi,
        //       tanggal: item.tanggal,
        //     ));
        //   }
        // }
        emit( StockOpnameSuccess(res));
         List? list = await db.getAllFormat();
         List<String> existingPos = list!.map((e) => e['location'] as String).toList();
         List? listSave = await dbSave.getAllFormat();
         List<String> existingData = list!.map((e) => e['location'] as String).toList();
        print('existingData1 ${existingData}');
        print('existingData2 ${listSave}');
        print('existingData3 ${list}');
        if (listSave!.isEmpty) {
          if (list.isEmpty) {
          for (var item in res.data!) {
          if (!existingPos.contains(item.lokasi)) {
           debugPrint('${item.lokasi}');
            db.save(SoGetDataModel(
              pos: item.pos,
              location: item.lokasi,
              tanggal: item.tanggal,
            ));
          }
        }
          } else {
            for (var activity in list) {
              for (var item in res.data!) {
          if (!existingPos.contains(item.lokasi)) {
           debugPrint('${item.lokasi}');
            db.save(SoGetDataModel(
              pos: item.pos,
              location: item.lokasi,
              tanggal: item.tanggal,
            ));
          }
        }
            } 
            }
        } else {
          print('Online namun tidak menambahkan ke lokal karena db save ada data');
        }
          
         
          
         
          debugPrint('Success' + res.toString());
        } else {
          emit( StockOpnameFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      });
    } catch (e) {
      emit( StockOpnameFailure(message: "Harap coba lagi..."));
    }
  }

  void postResult(String token, StockOpnameSubmitBody body) async {
    emit( StockOpnameSubmitLoading());
    try {
      await repositories.postResult(token, body).then((value) {
        if (value!.isSuccess && value.dataResponse is  StockOpnameSubmitResponse) {
          final res = value.dataResponse as  StockOpnameSubmitResponse;
          emit( StockOpnameSubmitSuccess(res));
          debugPrint('Success' + res.toString());
        } else {
          emit( StockOpnameSubmitFailure(message: value.dataResponse!));
          debugPrint('Failed' + value.dataResponse);
        }
      });
    } catch (e) {
      emit( StockOpnameSubmitFailure(message: "Harap coba lagi..."));
    }
  }

}
