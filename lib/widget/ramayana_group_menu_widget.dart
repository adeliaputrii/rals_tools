part of 'import.dart';

class PersonalMenuWidget extends StatelessWidget {
  const PersonalMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                baseParam.menuGroupPersonal,
                style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                menuIcon(baseParam.menuKartuPerusahaan, baseAsset.companyCardLogo, navigate: () => AppNavigator.navigateToKartuPerusahaan(context)),
                menuIcon(baseParam.menuTukarPoin, baseAsset.tukarPoinLogo, navigate: () => AppNavigator.navigateToTukarPoin(context)),
                menuIcon(baseParam.menuIdCash, baseAsset.idCashLogo, navigate: () => AppNavigator.navigateToIdCash(context)),
              ]),
            ),
          ],
        ));
  }
}

class ToolsMenuWidget extends StatelessWidget {
  const ToolsMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                baseParam.menuGroupTools,
                style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                menuIcon(baseParam.menuSuratJalan, baseAsset.suratJalanLogo, navigate: () => AppNavigator.navigateToSuratJalan(context)),
                menuIcon(baseParam.menuMyActivity, baseAsset.myActivityLogo, navigate: () => AppNavigator.navigateToMyActivity(context)),
                menuIcon(baseParam.menuVoid, baseAsset.voidLogo, navigate: () => AppNavigator.navigateToVoid(context))
              ]),
            ),
          ],
        ));
  }
}

class ReportMenuWidget extends StatelessWidget {
  const ReportMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                baseParam.menuGroupReport,
                style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                menuIcon(baseParam.menuLaporanSo, baseAsset.reportSoLogo, navigate: () => AppNavigator.navigateToReport(context)),
                menuIcon(baseParam.menuLaporanPooling, baseAsset.reportPoolingLogo, navigate: () => AppNavigator.navigateToReport(context)),
                menuIcon(baseParam.menuLaporanSales, baseAsset.reportSalesLogo, navigate: () => AppNavigator.navigateToReport(context)),
              ]),
            ),
          ],
        ));
  }
}

class AllMenuWidget extends StatelessWidget {
  const AllMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              baseParam.menuAll,
              style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    menuIcon(baseParam.menuKartuPerusahaan, baseAsset.companyCardLogo,
                        navigate: () => AppNavigator.navigateToKartuPerusahaan(context)),
                    menuIcon(baseParam.menuTukarPoin, baseAsset.tukarPoinLogo, navigate: () => AppNavigator.navigateToTukarPoin(context)),
                    menuIcon(baseParam.menuIdCash, baseAsset.idCashLogo, navigate: () => AppNavigator.navigateToIdCash(context)),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    menuIcon(baseParam.menuSuratJalan, baseAsset.suratJalanLogo, navigate: () => AppNavigator.navigateToSuratJalan(context)),
                    menuIcon(baseParam.menuMyActivity, baseAsset.myActivityLogo, navigate: () => AppNavigator.navigateToMyActivity(context)),
                    menuIcon(baseParam.menuVoid, baseAsset.voidLogo, navigate: () => AppNavigator.navigateToVoid(context))
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    menuIcon(baseParam.menuComCheck, baseAsset.comCheckLogo, navigate: () => AppNavigator.navigateToComCheck(context)),
                    menuIcon(baseParam.menuCekHarga, baseAsset.checkPriceLogo, navigate: () => AppNavigator.navigateToCheckPrice(context)),
                    menuIcon(baseParam.menuApprReturn, baseAsset.appReturnLogo, navigate: () => AppNavigator.navigateToApprReturn(context))
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    menuIcon(baseParam.menuLaporanSo, baseAsset.reportSoLogo, navigate: () => AppNavigator.navigateToReport(context)),
                    menuIcon(baseParam.menuLaporanPooling, baseAsset.reportPoolingLogo, navigate: () => AppNavigator.navigateToReport(context)),
                    menuIcon(baseParam.menuLaporanSales, baseAsset.reportSalesLogo, navigate: () => AppNavigator.navigateToReport(context)),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget menuIcon(String title, String asset, {required VoidCallback navigate}) {
  return GestureDetector(
    onTap: navigate,
    child: Column(
      children: [
        CircleAvatar(
          backgroundColor: Color.fromARGB(255, 207, 11, 11),
          radius: 30,
          backgroundImage: AssetImage(
            asset,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${title}',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400, wordSpacing: 2.0)),
        ),
      ],
    ),
  );
}
