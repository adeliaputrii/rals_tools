import 'package:barcode_widget/barcode_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myactivity_project/base/base_params.dart' as baseParam;
import 'package:myactivity_project/base/base_paths.dart' as basePath;
import 'package:myactivity_project/cubit/login/login_cubit.dart';
import 'package:myactivity_project/data/model/company_card_history_response.dart';
import 'package:myactivity_project/data/model/login_body.dart';
import 'package:myactivity_project/database/db_log.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/tools/settingsralstools.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';
import 'package:myactivity_project/utils/extension.dart';
import 'package:myactivity_project/utils/keyboard_utils.dart';
import 'package:myactivity_project/utils/popup_widget.dart';
import 'package:myactivity_project/widget/import.dart';
import 'package:native_id/native_id.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:flip_card/flip_card.dart';

import '../../cubit/company_card/company_card_cubit.dart';
import '../../cubit/id_cash/id_cash_cubit.dart';
import '../../data/model/company_card_history_response.dart';
import '../../data/model/company_card_response.dart' as ResponseCompany;
import '../../data/model/data_member_card_body.dart';
import '../../utils/app_media_query.dart';
import '../../utils/app_widgets.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColor;

part 'ramayana_membercard_authentication.dart';
part 'ramayana_membercard_card.dart';
part 'ramayana_membercard_trr.dart';
part 'ramayana_membercard_detail.dart';
part 'ramayana_membercard_qr.dart';
part 'ramayana_membercard_history.dart';
part 'ramayana_membercard_history_year.dart';
part 'ramayana_membercard_history_month.dart';
