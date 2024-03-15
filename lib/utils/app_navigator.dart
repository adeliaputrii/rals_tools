// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myactivity_project/utils/app_check_user.dart';
import 'package:myactivity_project/utils/popup_widget.dart';
import 'package:myactivity_project/widget/Membercard/import.dart';
import 'package:myactivity_project/base/base_params.dart' as baseParam;
import '../widget/Approval Return/import.dart';
import '../widget/Cek Harga/import.dart';
import '../widget/Competitor Checking/import.dart';
import '../widget/ID CASH/import.dart';
import '../widget/My Activity/import.dart';
import '../widget/Report/import.dart';
import '../widget/Tracking Surat Jalan/import.dart';
import '../widget/Tukar Poin/import.dart';
import '../widget/VOID/import.dart';
import 'app_shared_pref.dart';

class AppNavigator {
  AppNavigator._();

  static void navigateToKartuPerusahaan(BuildContext context) async {
    final listAccess = await SharedPref.getUserAccess() ?? '';
    if (listAccess.contains(baseParam.menuKeyCompanyCard)) {
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const RamayanaMembercardAuthentication();
      }));
    } else {
      showRestrictMessenger(context);
    }
  }

  static void navigateToTukarPoin(BuildContext context) async {
    final listAccess = await SharedPref.getUserAccess() ?? '';
    if (listAccess.contains(baseParam.menuKeyTukarPoin)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const RamayanaTukarPoin();
      }));
    } else {
      showRestrictMessenger(context);
    }
  }

  static void navigateToIdCash(BuildContext context) async {
    final listAccess = await SharedPref.getUserAccess() ?? '';
    if (listAccess.contains(baseParam.menuKeyIdCash)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const RamayanaIDCash();
      }));
    } else {
      showRestrictMessenger(context);
    }
  }

  static void navigateToSuratJalan(BuildContext context) async {
    final listAccess = await SharedPref.getUserAccess() ?? '';
    if (listAccess.contains(baseParam.menuKeySj)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RamayanaSuratJalan();
      }));
    } else {
      showRestrictMessenger(context);
    }
  }

  static void navigateToMyActivity(BuildContext context) async {
    final listAccess = await SharedPref.getUserAccess() ?? '';
    if (listAccess.contains(baseParam.menuKeyMyActivity)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RamayanaMyActivity();
      }));
    } else {
      showRestrictMessenger(context);
    }
  }

  static void navigateToVoid(BuildContext context) async {
    final listAccess = await SharedPref.getUserAccess() ?? '';
    if (listAccess.contains(baseParam.menuKeyVoid)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RamayanaVoid(
          isOffline: false,
        );
      }));
    } else {
      showRestrictMessenger(context);
    }
  }

  static void navigateToCheckPrice(BuildContext context) async {
    final listAccess = await SharedPref.getUserAccess() ?? '';
    if (listAccess.contains(baseParam.menuKeyCekPrice)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RamayanaCariToko();
      }));
    } else {
      showRestrictMessenger(context);
    }
  }

  static void navigateToComCheck(BuildContext context) async {
    final listAccess = await SharedPref.getUserAccess() ?? '';
    if (listAccess.contains(baseParam.menuKeyApprovedComCheck)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RamayanaCompetitorCek();
      }));
    } else {
      showRestrictMessenger(context);
    }
  }

  static void navigateToApprReturn(BuildContext context) async {
    final listAccess = await SharedPref.getUserAccess() ?? '';
    if (listAccess.contains(baseParam.menuKeyApprovalReturn)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RamayanaApprovalReturn();
      }));
    } else {
      showRestrictMessenger(context);
    }
  }

  static void navigateToReportSalesDetail(BuildContext context, String? url, String title) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ReportSalesDetailPager(url: url, title: title);
    }));
  }

  static void navigateToReportSalesList(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ReportSalesList();
    }));
  }

  static void navigateToReport(BuildContext context) async {
    PopUpWidget(context).showPopUpWarning('Update selanjutnya..', 'Kembali');
  }
}

void showRestrictMessenger(BuildContext context) {
  PopUpWidget(context).showPopUpWarning('Anda tidak mempunyai akses', 'Kembali');
}
