part of 'import.dart';

class CardReport extends StatelessWidget {
  PagingResponse.Data response;
  CardReport({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        AppNavigator.navigateToReportSalesDetail(context, response.properties, response.header1!);
      },
      child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
          decoration: BoxDecoration(color: baseColor.cardReportColor, borderRadius: BorderRadius.circular(20)),
          height: screenSize.height/9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: baseColor.cardImageBackground, borderRadius: BorderRadius.circular(10)),
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
                              Text(
                                '${response.status}',
                                style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w500, color: baseColor.graySecondary),
                              ),
                              Text(
                                '${response.header1}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: baseColor.grayPrimary,
                                  wordSpacing: 2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('${response.createDate}',
                                  style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w400, color: baseColor.graySecondary))
                            ],
                          ),
                        ),
                        Image(
                          width: 40,
                          height: 40,
                          image: AssetImage(baseAsset.icReportArrow),
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
