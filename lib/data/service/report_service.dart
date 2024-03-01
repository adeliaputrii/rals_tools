import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;
import 'package:retrofit/http.dart';

import '../model/report_list_response.dart';

part 'report_service.g.dart';

@RestApi()
abstract class ReportService {
  factory ReportService(Dio dio, {String baseUrl}) = _ReportService;

  @GET(basePath.api_report_list)
  Future<List<ReportListResponse>> getListReport();
}
