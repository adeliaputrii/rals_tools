
import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColor;
import 'package:myactivity_project/base/base_params.dart' as baseParam;
import 'package:myactivity_project/base/base_paths.dart' as basePath;
import 'package:myactivity_project/base/base_params.dart';
import 'package:myactivity_project/cubit/login/login_cubit.dart';
import 'package:myactivity_project/cubit/stock_opname/so_cubit.dart';
import 'package:myactivity_project/data/model/stock_opname_body.dart';
import 'package:myactivity_project/data/model/stock_opname_submit_body.dart';
import 'package:myactivity_project/database/StockOpname/db_get_data.dart';
import 'package:myactivity_project/database/StockOpname/db_save_data.dart';
import 'package:myactivity_project/database/db_so.dart';
import 'package:myactivity_project/models/StockOpname/model_getData.dart';
import 'package:myactivity_project/models/StockOpname/model_saveData.dart';
import 'package:myactivity_project/models/StockOpname/model_so.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/tools/settingsralstools.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';
import 'package:myactivity_project/utils/app_widgets.dart';
import 'package:myactivity_project/utils/popup_widget.dart';
import 'package:myactivity_project/widget/import.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

import 'ramayana_so_popup.dart';

part 'ramayana_formSo.dart';