import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myactivity_project/utils/app_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColor;
import 'package:myactivity_project/base/base_assets.dart' as baseAsset;
import 'package:myactivity_project/base/base_params.dart' as baseParam;
import 'package:myactivity_project/utils/app_navigator.dart';
import '../../cubit/report/report_cubit.dart';
import '../../data/model/report_list_response.dart';
import '../../data/model/report_list_pagination_response.dart' as PagingResponse;
import '../../utils/keyboard_utils.dart';
import '../../utils/popup_widget.dart';

part 'report_sales_detail.dart';
part 'report_sales_card.dart';
part 'report_sales_list.dart';