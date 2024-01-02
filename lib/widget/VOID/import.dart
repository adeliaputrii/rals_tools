import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myactivity_project/base/base_params.dart';
import 'package:myactivity_project/cubit/login/login_cubit.dart';
import 'package:myactivity_project/database/db_log_void_offline.dart';
import 'package:myactivity_project/models/Login%20Offline/model_log_void_offline.dart';
import 'package:myactivity_project/models/My List Task/model_task_home.dart';
import 'package:myactivity_project/models/My%20Activity/model_jumlah_list_task.dart';
import 'package:myactivity_project/service/notification/notification_service.dart';
import 'package:myactivity_project/widget/Login/import.dart';
import 'package:myactivity_project/widget/import.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myactivity_project/database/db_log.dart';
import 'package:myactivity_project/models/Approval Return/model_approval_return.dart';
import 'package:myactivity_project/models/Hak Akses/model_hakakses.dart';
import 'package:myactivity_project/models/ID CASH/model_idacash_cust.dart';
import 'package:myactivity_project/models/ID CASH//model_idcash.dart';
import 'package:myactivity_project/models/My Activity/model_list_project.dart';
import 'package:myactivity_project/models/My Activity/model_list_task.dart';
import 'package:myactivity_project/models/model_log.dart';
import 'package:myactivity_project/models/Competitor Checking/model_tabel_approve.dart';
import 'package:myactivity_project/models/Cek Harga/model_toko.dart';
import 'package:myactivity_project/models/Approval Return/models_approval_return_list.dart';
import 'package:myactivity_project/tools/device_info.dart';
import 'package:myactivity_project/service/API_service/API_service.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/tools/settingsralstools.dart';
import 'package:myactivity_project/base/base_params.dart' as baseParam;
import 'package:myactivity_project/base/base_paths.dart' as basePath;
import '../../utils/keyboard_utils.dart';

part 'ramayana_void.dart';
