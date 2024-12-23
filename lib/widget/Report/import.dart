import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myactivity_project/base/base_assets.dart' as baseAsset;
import 'package:myactivity_project/base/base_colors.dart' as baseColor;
import 'package:myactivity_project/base/base_colors.dart' as baseColors;
import 'package:myactivity_project/base/base_params.dart' as baseParam;
import 'package:myactivity_project/base/base_paths.dart' as basePath;
import 'package:myactivity_project/data/model/report_sales_body.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/utils/app_navigator.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';
import 'package:myactivity_project/utils/app_widgets.dart';
import 'package:myactivity_project/widget/Report/report_summry_detail_sales.dart';
import 'package:myactivity_project/widget/import.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../cubit/login/login_cubit.dart';
import '../../cubit/report/report_cubit.dart';
import '../../data/model/report_list_pagination_response.dart' as PagingResponse;
import '../../data/model/report_list_response.dart';
import '../../data/model/report_webview_model.dart';
import '../../utils/popup_widget.dart';

part 'report_sales_card.dart';
part 'report_sales_detail.dart';
part 'report_sales_detail_pager.dart';
part 'report_sales_list.dart';
part 'report_sales_search.dart';
part 'report_webview.dart';
