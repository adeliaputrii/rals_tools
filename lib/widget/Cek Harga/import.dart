import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myactivity_project/models/Cek%20Harga/model_cekpromo.dart';
import 'package:myactivity_project/models/Cek%20Harga/model_searchtoko.dart';
import 'package:myactivity_project/models/Cek%20Harga/model_toko.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/tools/settingsralstools.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myactivity_project/widget/import.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myactivity_project/base/base_params.dart' as baseParam;

import '../../cubit/login/login_cubit.dart';

part 'ramayana_caritoko.dart';
part 'ramayana_cekharga.dart';
