import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:myactivity_project/data/model/lspb_form_body.dart';
import 'package:myactivity_project/data/model/lspb_form_response.dart';
import 'package:myactivity_project/data/model/lspb_type_doc_response.dart';
import 'package:myactivity_project/data/model/lspb_view_response.dart';
import 'package:myactivity_project/data/model/stock_opname_body.dart';
import 'package:myactivity_project/data/model/stock_opname_list_response.dart';
import 'package:myactivity_project/data/model/stock_opname_response.dart';
import 'package:myactivity_project/data/model/stock_opname_submit_body.dart';
import 'package:myactivity_project/data/model/stock_opname_submit_reponse.dart';
import 'package:retrofit/retrofit.dart';
import 'package:myactivity_project/base/base_paths.dart' as basePath;

part 'lspb_service.g.dart';


@RestApi()
abstract class LspbService {
  factory LspbService(Dio dio, {String baseUrl}) = _LspbService;

  @POST(basePath.api_post_form)
  Future<LspbFormResponse> postFormLspb(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Body() LspbFormBody body
  );

  @GET('${basePath.api_get_view_lspb}{scan_dokumen}&user={user}&store={store}')
  Future<LspbViewRequestResponse> getViewLspb(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Path("scan_dokumen") String scan_dokumen,
    @Path("user") String user,
    @Path("store") String store
  );

  @GET('${basePath.api_get_type_doc}{scan_dokumen}&user={user}')
  Future<LspbTypeDocResponse> getTypeDoc(
    @Header("Content-Type") String contentType,
    @Header("Accept") String accept,
    @Header("Authorization") String token,
    @Path("scan_dokumen") String scan_dokumen,
    @Path("user") String user,
  );
}