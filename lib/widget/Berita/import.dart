import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myactivity_project/cubit/login/login_cubit.dart';
import 'package:myactivity_project/models/Berita/model_news.dart';
import 'package:myactivity_project/service/API_service/API_service.dart';
import 'package:myactivity_project/tools/settingsralstools.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';
import 'package:myactivity_project/utils/popup_widget.dart';
import 'package:myactivity_project/widget/Report/import.dart';
import 'package:myactivity_project/widget/import.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbib_splash_screen/tbib_splash_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../data/model/news_list_response.dart' as NewsListResponse;
import 'package:myactivity_project/base/base_params.dart' as baseParam;
import 'package:myactivity_project/base/base_paths.dart' as basePath;
import 'package:myactivity_project/base/base_colors.dart' as baseColors;
import '../../cubit/home/home_cubit.dart';
import '../../utils/app_widgets.dart';

part 'ramayana_news.dart';
part 'ramayana_news_detail.dart';
