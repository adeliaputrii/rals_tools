import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myactivity_project/data/model/data_customer_response.dart';
import 'package:myactivity_project/data/model/report_list_response.dart';
import '../../data/model/report_list_pagination_response.dart';
import '../../data/repository/report_repository.dart';
import '../../service/SP_service/SP_service.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

  final ReportRepositories repositories = ReportRepositories();
  UserData userData = UserData();

  void getListReport() async {
    emit(ReportLoading());
    await repositories.getListReport().then((value) {
      if (value.isSuccess && value.dataResponse is List<ReportListResponse>) {
        final res = value.dataResponse as List<ReportListResponse>;
        emit(ReportSuccess(res));
      } else {
        emit(ReportFailure(message: value.dataResponse!));
      }
    });
  }

  void getListReportPagination(String? cursor, String? title, String? startDate, String? endDate) async {
    emit(ReportLoading());
    await repositories.getListReportPagination(cursor, title, startDate, endDate).then((value) {
      if (value.isSuccess && value.dataResponse is ReportListPaginationResponse) {
        final res = value.dataResponse as ReportListPaginationResponse;
        emit(ReportPaginationSuccess(res));
      } else {
        emit(ReportFailure(message: value.dataResponse!));
      }
    });
  }

  void searchListReport(String? cursor, String? title, String? startDate, String? endDate) async {
    emit(ReportLoading());
    await repositories.searchListReport(cursor, title, startDate, endDate).then((value) {
      if (value.isSuccess && value.dataResponse is ReportListPaginationResponse) {
        final res = value.dataResponse as ReportListPaginationResponse;
        emit(ReportSearchSuccess(res));
      } else {
        emit(ReportFailure(message: value.dataResponse!));
      }
    });
  }
}
