// import 'dart:convert';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myactivity_project/data/model/check_price_body.dart';
// import 'package:myactivity_project/data/model/check_price_response.dart';
// import 'package:myactivity_project/data/repository/check_price_repository.dart';
// import 'package:myactivity_project/service/SP_service/SP_service.dart';
// import '../../data/model/check_price_response.dart';
// import '../../utils/app_shared_pref.dart';

// part 'check_price_state.dart';

// class CheckPriceCubit extends Cubit<CheckPriceState> {
//   CheckPriceCubit() : super(CheckPriceInitial());

//   final CheckPriceRepositories repositories = CheckPriceRepositories();

//   final _repo = CheckPriceRepositories();
//   UserData userData = UserData();

//   void checkprice({required CheckPriceBody checkprice}) async {
//     emit(CheckPriceLoading());
//     await repositories.checkprice(checkprice).then((value) {
//       if (value.isSuccess && value.dataResponse is CheckPriceResponse) {
//         final res = value.dataResponse as CheckPriceResponse;
//         emit(CheckPriceSuccess(res));
//         debugPrint('Success' + res.toString());
//       } else {
//         emit(CheckPriceFailure(message: value.dataResponse!));
//         debugPrint('Failed' + value.dataResponse);
      
//       }
//     });
//   }
// }
