import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;
import 'package:myactivity_project/data/model/report_list_pagination_response.dart';
import 'package:retrofit/http.dart';

import '../model/report_list_response.dart';

part 'report_service.g.dart';

@RestApi()
abstract class ReportService {
  factory ReportService(Dio dio, {String baseUrl}) = _ReportService;

  @GET(basePath.api_report_list)
  Future<List<ReportListResponse>> getListReport();

  @GET('${basePath.api_report_list_pagination}{cursor}')
  Future<ReportListPaginationResponse> getListReportPagination(@Path("cursor") String query);

  @GET('${basePath.api_report_list_pagination}{cursor}&header={title}&start_date={startdate}&end_date={enddate}')
  Future<ReportListPaginationResponse> searchListReport(
      @Path("cursor") String? cursor, @Path("title") String? title, @Path("startdate") String? startDate, @Path("enddate") String? endDate);
}
