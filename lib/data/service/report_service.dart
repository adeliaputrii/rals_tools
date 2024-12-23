import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;
import 'package:myactivity_project/data/model/report_list_pagination_response.dart';
import 'package:myactivity_project/data/model/report_sales_body.dart';
import 'package:myactivity_project/data/model/report_sales_response.dart';
import 'package:retrofit/http.dart';

import '../model/report_list_response.dart';

part 'report_service.g.dart';

@RestApi()
abstract class ReportService {
  factory ReportService(Dio dio, {String baseUrl}) = _ReportService;

  @GET(basePath.api_report_list)
  Future<List<ReportListResponse>> getListReport(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
  );

  @GET('${basePath.api_report_list_pagination}{cursor}')
  Future<ReportListPaginationResponse> getListReportPagination(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Path("cursor") String query
  );

  @GET('${basePath.api_report_list_pagination}{cursor}&header={title}&start_date={startdate}&end_date={enddate}&version={version}')
  Future<ReportListPaginationResponse> searchListReport(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Path("cursor") String? cursor, 
    @Path("title") String? title,
    @Path("startdate") String? startDate,
    @Path("enddate") String? endDate, 
    @Path("version") String? version
  );

  @POST('${basePath.api_report_insert_viewer}')
  Future<ReportListPaginationResponse> insertViewer(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() Map<String, dynamic> idReport
  );

  
@POST('${basePath.api_report_sales}')
  Future<SalesReportResponse> getSalesReport(
      @Header("Content-Type") String contentType,
      @Header("Accept") String accept,
      @Body() ReportSalesBody reportBody);


}
