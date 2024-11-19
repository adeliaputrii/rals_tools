part of 'import.dart';

class CardReport extends StatelessWidget {
  PagingResponse.Data response;

  CardReport({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final String date = '${response.createDate}';
    return GestureDetector(
      onTap: () {
        debugPrint('sales card ${response.idReport}');
        AppNavigator.navigateToReportSalesDetail(context, response.idReport.toString(), response.properties, response.header1!);
      },
      child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
          decoration: BoxDecoration(color: baseColor.cardReportColor, 
          boxShadow: [BoxShadow(
            offset: Offset(2,3),
            color: Colors.grey,
            blurRadius: 3
          )],
          borderRadius: BorderRadius.circular(20)),
          height: screenSize.height / 12,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: baseColor.cardImageBackground,
                  borderRadius: BorderRadius.circular(10)),
                  child: Image(
                    width: 40,
                    height: 40,
                    image: AssetImage(baseAsset.icReportList),
                  ),
                ),
                Container(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${response.status}',
                                    style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w500, color: baseColor.graySecondary),
                                  ),
                                  Text(
                                    '${response.category}',
                                    style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w500, color: baseColor.graySecondary),
                                  ),
                                  Text('${date.substring(0, 10)}',
                                    style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w400, color: baseColor.graySecondary)),
                                ],
                              ),
                              Text(
                                '${response.header1?.toUpperCase()}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: baseColor.grayPrimary,
                                  wordSpacing: 2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: false,
                              child: Image(
                                image: AssetImage(baseAsset.icEyes),
                              ),
                            ),
                            Image(
                              width: 40,
                              height: 40,
                              image: AssetImage(baseAsset.icReportArrow),
                            ),
                            Row(
                              children: [
                                Image(
                                  width: 15,
                                  height: 15,
                                  image: AssetImage(baseAsset.icEyes),
                                ),
                                const SizedBox(width: 10),
                                Text('${response.viewer}',
                                    style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w400, color: baseColor.graySecondary)),
                              ],
                            )
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
}
