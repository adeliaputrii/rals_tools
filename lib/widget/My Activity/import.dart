library quill_html_converter;
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:notification_permissions/notification_permissions.dart' as notifPermission;
import 'package:permission_handler/permission_handler.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColors;
import 'package:myactivity_project/base/base_params.dart' as baseParam;
import 'package:myactivity_project/base/base_paths.dart' as basePath;
import 'package:myactivity_project/data/model/get_task_response.dart' as GetTaskResponse;
import 'package:myactivity_project/data/model/myactivity_body.dart';
import 'package:myactivity_project/data/model/myactivity_edit_body.dart';
import 'package:myactivity_project/data/model/myactivity_edit_response.dart' as MyActivityEditResponse;
import 'package:myactivity_project/data/model/myactivity_edit_response.dart';
import 'package:myactivity_project/data/model/myactivity_update_body.dart';
import 'package:myactivity_project/models/My%20Activity/model_edit_myactivity.dart';
import 'package:myactivity_project/models/My%20Activity/model_list_project.dart';
import 'package:myactivity_project/models/My%20Activity/model_list_task.dart';
import 'package:myactivity_project/service/API_service/API_service.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/tools/settingsralstools.dart';
import 'package:myactivity_project/widget/import.dart';

import '../../cubit/login/login_cubit.dart';
import '../../cubit/myactivity/myactivity_cubit.dart';
import '../../utils/app_datetime_utlis.dart';
import '../../utils/app_media_query.dart';
import '../../utils/app_widgets.dart';
import '../../utils/popup_widget.dart';

part 'ramayana_myactivity_edit.dart';
part 'ramayana_myactivity_new.dart';
part 'ramayana_myactivity_popup.dart';
part 'ramayana_myactivity_project.dart';
part 'ramayana_myactivity_task.dart';

