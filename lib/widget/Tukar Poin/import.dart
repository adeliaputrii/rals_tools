import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
// import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:myactivity_project/cubit/login/login_cubit.dart';
import 'package:myactivity_project/database/db_log.dart';
import 'package:myactivity_project/models/model_log.dart';
import 'package:myactivity_project/widget/import.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:myactivity_project/tools/settingsralstools.dart';
import 'package:http/http.dart' as http;
import 'package:myactivity_project/base/base_params.dart' as baseParam;
import 'package:myactivity_project/base/base_paths.dart' as basePath;
part 'ramayana_tukar_poin.dart';
// part 'ramayana_tukar_poin2.dart';
