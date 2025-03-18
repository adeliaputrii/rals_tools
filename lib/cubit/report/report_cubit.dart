import 'dart:async';

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myactivity_project/data/model/data_customer_response.dart';
import 'package:myactivity_project/data/model/report_dynamic_body.dart';
import 'package:myactivity_project/data/model/report_get_store_body.dart';
import 'package:myactivity_project/data/model/report_get_store_response.dart';
import 'package:myactivity_project/data/model/report_list_response.dart';
import 'package:myactivity_project/data/model/report_sales_body.dart';
import 'package:myactivity_project/data/model/report_sales_response.dart';
import 'package:myactivity_project/data/model/response_report_dynamic.dart';
import 'package:myactivity_project/data/model/response_report_dynamic_header.dart';
import 'package:myactivity_project/tools/settingsralstools.dart';

import '../../data/model/report_list_pagination_response.dart';
import '../../data/repository/report_repository.dart';
import '../../service/SP_service/SP_service.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());
  Timer? _debounceTimer;
  final ReportRepositories repositories = ReportRepositories();
  UserData userData = UserData();
  List<ReportData> reportList = []; // Simpan daftar report di sini

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

  void getListReport(String token) async {
    await repositories.getListReport(token).then((value) {
      if (value.isSuccess && value.dataResponse is List<ReportListResponse>) {
        final res = value.dataResponse as List<ReportListResponse>;
        emit(ReportSuccess(res));
      } else {
        emit(ReportFailure(message: value.dataResponse!));
      }
    });
  }

  void getListReportPagination(String token, String? cursor, String? title,
      String? startDate, String? endDate) async {
    emit(ReportLoading());
    await repositories
        .getListReportPagination(
            token, cursor, title, startDate, endDate, versi)
        .then((value) {
      if (value.isSuccess &&
          value.dataResponse is ReportListPaginationResponse) {
        final res = value.dataResponse as ReportListPaginationResponse;
        emit(ReportPaginationSuccess(res));
      } else {
        emit(ReportFailure(message: value.dataResponse!));
      }
    });
  }

  void searchListReport(String token, String? cursor, String? title,
      String? startDate, String? endDate) async {
    emit(ReportLoading());
    await repositories
        .searchListReport(token, cursor, title, startDate, endDate, versi)
        .then((value) {
      if (value.isSuccess &&
          value.dataResponse is ReportListPaginationResponse) {
        final res = value.dataResponse as ReportListPaginationResponse;
        emit(ReportSearchSuccess(res));
      } else {
        emit(ReportFailure(message: value.dataResponse));
      }
    });
  }

  void insertViewer(String token, String idReport) async {
    emit(ReportLoading());
    await repositories.insertViewer(token, idReport).then((value) {
      if (value.isSuccess &&
          value.dataResponse is ReportListPaginationResponse) {
        final res = value.dataResponse as ReportListPaginationResponse;
        emit(ReportInsertViewerSuccess(res));
      } else {
        emit(ReportFailure(message: value.dataResponse!));
      }
    });
  }

  void getSalesReport(String token, ReportSalesBody reportBody) async {
    emit(ReportLoading());

    final value = await repositories.getSalesReport(token, reportBody);

    if (value.isSuccess) {
      final responseData = value.dataResponse as SalesReportResponse;
      emit(ReportSalesSuccess(responseData.data));
    } else {
      log("Error in getSalesReport:");
      emit(ReportFailure(message: value.dataResponse.toString()));
    }
  }

  void getStore(String token, SalesDataStore reportBody) async {
    emit(ReportLoading());

    await repositories.getStore(token, reportBody).then((value) {
      final responseData = value.dataResponse as SalesReportStoreResponse;
      if (value.isSuccess) {
        var storeData = responseData.data;

        if (storeData.isNotEmpty) {
          emit(getStoreSuccess(storeData));
        } else {
          log("ke");

          emit(ReportFailure(message: "No stores available"));
        }
      } else {
        log("ke else");
        emit(ReportFailure(message: value.dataResponse ?? "Unknown error"));
      }
    }).catchError((e) {
      log("ke catch");

      emit(ReportFailure(message: "An error occurred during the request"));
    });
  }

  void getReportdynamic(String token, String reportId) async {
    emit(ReportLoading());

    final reportBody = ReportModel(reportId: reportId); // Buat objek yang benar
    print(reportBody);
    print("Cubitt");

    final result = await repositories.getReportDynamic(token, reportBody);

    if (result.isSuccess && result.dataResponse is ReportResponse) {
      final responseData = result.dataResponse as ReportResponse;
      emit(ReportgetDynamicSuccess(responseData.data));
    } else {
      emit(ReportFailure(message: result.dataResponse));
    }
  }

  void getReportdynamicHeader(String token) async {
    emit(ReportLoading());
    log("Cubitt Header dipanggil...");

    final result = await repositories.getReportDynamicHeader(token);
    log("Response diterima: ${result.dataResponse.runtimeType}"); // Cek tipe datanya

    if (result.isSuccess && result.dataResponse is ResponseReportDynamic) {
      final responseData = result.dataResponse as ResponseReportDynamic;
      log("Response Data: ${responseData.data}");

      emit(ReportgetDynamicHeaderSuccess(responseData.data));
      log("kesini succses");
    } else {
      log("kesini error: ${result.dataResponse.runtimeType}");
      emit(ReportFailure(
          message:
              "Tipe data tidak sesuai: ${result.dataResponse.runtimeType}"));
    }
  }
}
