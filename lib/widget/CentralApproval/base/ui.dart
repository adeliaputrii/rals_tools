part of '../import.dart';

Widget viewPDF(String? type, Function? widgetFunction ,BuildContext context){
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 10,),
        Center(
          child: SizedBox(
            width: 450,
            height: 650,
            child: SfPdfViewer.network(
              'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
              key: _pdfViewerKey,
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
              child: Text(
                'History Approval',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                ),
              )
          ),
        ),
        const SizedBox(height: 10,),
        timelineDataCustom(context),
        const SizedBox(height: 10,),
        widgetFunction!(),
        const SizedBox(height: 20,),
      ] ,
    ),
  );
}

Widget timelineDataCustom(BuildContext context){
  return Container(
    alignment: Alignment.topLeft,
    child: FixedTimeline.tileBuilder(
      theme: TimelineTheme.of(context).copyWith(
        nodePosition: 0.15,
      ),
      builder: TimelineTileBuilder.fromStyle(
        oppositeContentsBuilder: (context, index) => const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('19\nJuni'),
        ),
        contentsAlign: ContentsAlign.basic,
        connectorStyle: ConnectorStyle.solidLine,
        indicatorStyle: IndicatorStyle.outlined,
        contentsBuilder: (context, index) => const Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            child: ListTile(
              leading: Icon(Icons.people),
              title: Text("David Khu Husin"),
              subtitle: Text('Aprroval pada tanggal 19 Juni 2024'),
              // trailing: Icon(Icons.more_vert),
              // onTap: () {},
            ),
          ),
        ),
        itemCount: 2,
      ),
    ),
  );
}

Widget expansionTileCustom(String? title,String? subtitle,IconData? icon,BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Card(
      child: ExpansionTile(
          leading: Icon(icon),
          title: Text(
            title!,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text('$subtitle',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              )
          ),
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(icon),
                    title: Text(
                      'GR',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    subtitle: Text('Awaiting Approval : 10',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RamayanaCentralApprovalList()
                        ),
                      );
                    },
                  ),
                )
            ),
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(icon),
                    title: Text(
                      'GR',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    subtitle: Text('Awaiting Approval : 10',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    onTap: () {},
                  ),
                )
            )
          ]
      ),
    ),
  );
}

Widget listTileCustom(String? title,String? subtitle,IconData? icon,BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  // final String date = '${response.createDate}';
  return GestureDetector(
    onTap: () {
      // debugPrint('sales card ${response.idReport}');
      AppNavigator.navigateToCADetail(context, null, null, null);
      // AppNavigator.navigateToReportSalesDetail(context, response.idReport.toString(), response.properties, response.header1!);
    },
    child: Container(
        margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
        decoration: BoxDecoration(color: baseColor.cardReportColor, borderRadius: BorderRadius.circular(20)),
        height: screenSize.height / 12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(color: baseColor.cardImageBackground, borderRadius: BorderRadius.circular(10)),
                child: const Image(
                  width: 40,
                  height: 40,
                  image: AssetImage(baseAsset.icReportList),
                ),
              ),
              SizedBox(
                width: screenSize.width / 1.3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${title}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: baseColor.grayPrimary,
                                wordSpacing: 2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${subtitle}',
                              style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w500, color: baseColor.graySecondary),
                            ),
                          ],
                        ),
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(
                            width: 40,
                            height: 40,
                            image: AssetImage(baseAsset.icReportArrow),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
  );
}

// Widget listMenu(BuildContext context){
//
// }

// Widget listDetails(BuildContext context){
//
// }

// Widget responseAction(BuildContext context){
//
// }