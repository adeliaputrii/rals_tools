part of 'import.dart';

class RamayanaMembercardHistory extends StatefulWidget {
  const RamayanaMembercardHistory({super.key, required this.color});
  final bool color;
  static const route = '/ramayana-list-screen';
  @override
  State<RamayanaMembercardHistory> createState() => _RamayanaMembercardHistoryState();
}

class _RamayanaMembercardHistoryState extends State<RamayanaMembercardHistory> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
                  onPressed: () {
        Navigator.pop(context);
                  },
                  icon: Icon(
        Icons.arrow_back_ios,
        color: Color.fromARGB(255, 230, 0, 0),
                  ),
                ),
        title: Text('Kembali',
            style: GoogleFonts.rubik(
              fontSize: 23,
              color: Color.fromARGB(255, 230, 0, 0),)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Stack(children: [
            Container(
              color: Colors.white,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: Text('Riwayat Transaksi',
                      style: GoogleFonts.rubik(
                          fontSize: 31,
                          color: 
                          widget.color
                          ?
                          Color.fromARGB(255,197,18,19)
                          :
                          Color.fromARGB(255,82,74,156),
                          fontWeight: FontWeight.w500)),
                ),
                 Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text('Januari',
                        style: GoogleFonts.rubik(
                            fontSize: 22,
                            color: 
                            widget.color
                            ?
                            Color.fromARGB(255,197,18,19)
                            :
                            Color.fromARGB(255,82,74,156))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
                  height: 1,
                  color: 
                  widget.color
                  ?
                  Color.fromARGB(255,197,18,19)
                  :
                  Color.fromARGB(255,82,74,156)
                ),
                                   Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    decoration: BoxDecoration(
                                    color: 
                                    widget.color
                                    ?
                                    Color.fromARGB(255,190,215,44)
                                    :
                                    Color.fromARGB(255, 255, 207, 228),
                                    borderRadius: BorderRadius.circular(20)
                                    ),
                                    height: 70,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          IconlyBold.bag,
                                          color: 
                                          widget.color
                                          ?
                                          Color.fromARGB(255,197,18,19)
                                          :
                                          Color.fromARGB(255,82,74,156),
                                          size: 28,
                                        ),
                                        title: Text(
                                          'Tropikana Drink',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                            widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '17/12/2023',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            color: 
                                             widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          'RP. 20.000.000',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                             widget.color
                                            ?
                                            Color.fromARGB(255,197,18,19)
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        ),
                                    )
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    decoration: BoxDecoration(
                                    color: 
                                    widget.color
                                    ?
                                    Color.fromARGB(255,190,215,44)
                                    :
                                    Color.fromARGB(255, 255, 207, 228),
                                    borderRadius: BorderRadius.circular(20)
                                    ),
                                    height: 70,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          IconlyBold.bag,
                                          color: 
                                          widget.color
                                          ?
                                          Color.fromARGB(255,197,18,19)
                                          :
                                          Color.fromARGB(255,82,74,156),
                                          size: 28,
                                        ),
                                        title: Text(
                                          'Tropikana Drink',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                            widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '17/12/2023',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            color: 
                                             widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          'RP. 20.000.000',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                             widget.color
                                            ?
                                            Color.fromARGB(255,197,18,19)
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        ),
                                    )
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    decoration: BoxDecoration(
                                    color: 
                                    widget.color
                                    ?
                                    Color.fromARGB(255,190,215,44)
                                    :
                                    Color.fromARGB(255, 255, 207, 228),
                                    borderRadius: BorderRadius.circular(20)
                                    ),
                                    height: 70,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          IconlyBold.bag,
                                          color: 
                                          widget.color
                                          ?
                                          Color.fromARGB(255,197,18,19)
                                          :
                                          Color.fromARGB(255,82,74,156),
                                          size: 28,
                                        ),
                                        title: Text(
                                          'Tropikana Drink',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                            widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '17/12/2023',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            color: 
                                             widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          'RP. 20.000.000',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                             widget.color
                                            ?
                                            Color.fromARGB(255,197,18,19)
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        ),
                                    )
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    decoration: BoxDecoration(
                                    color: 
                                    widget.color
                                    ?
                                    Color.fromARGB(255,190,215,44)
                                    :
                                    Color.fromARGB(255, 255, 207, 228),
                                    borderRadius: BorderRadius.circular(20)
                                    ),
                                    height: 70,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          IconlyBold.bag,
                                          color: 
                                          widget.color
                                          ?
                                          Color.fromARGB(255,197,18,19)
                                          :
                                          Color.fromARGB(255,82,74,156),
                                          size: 28,
                                        ),
                                        title: Text(
                                          'Tropikana Drink',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                            widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '17/12/2023',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            color: 
                                             widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          'RP. 20.000.000',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                             widget.color
                                            ?
                                            Color.fromARGB(255,197,18,19)
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        ),
                                    )
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    decoration: BoxDecoration(
                                    color: 
                                    widget.color
                                    ?
                                    Color.fromARGB(255,190,215,44)
                                    :
                                    Color.fromARGB(255, 255, 207, 228),
                                    borderRadius: BorderRadius.circular(20)
                                    ),
                                    height: 70,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          IconlyBold.bag,
                                          color: 
                                          widget.color
                                          ?
                                          Color.fromARGB(255,197,18,19)
                                          :
                                          Color.fromARGB(255,82,74,156),
                                          size: 28,
                                        ),
                                        title: Text(
                                          'Tropikana Drink',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                            widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '17/12/2023',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            color: 
                                             widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          'RP. 20.000.000',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                             widget.color
                                            ?
                                            Color.fromARGB(255,197,18,19)
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        ),
                                    )
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    decoration: BoxDecoration(
                                    color: 
                                    widget.color
                                    ?
                                    Color.fromARGB(255,190,215,44)
                                    :
                                    Color.fromARGB(255, 255, 207, 228),
                                    borderRadius: BorderRadius.circular(20)
                                    ),
                                    height: 70,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          IconlyBold.bag,
                                          color: 
                                          widget.color
                                          ?
                                          Color.fromARGB(255,197,18,19)
                                          :
                                          Color.fromARGB(255,82,74,156),
                                          size: 28,
                                        ),
                                        title: Text(
                                          'Tropikana Drink',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                            widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '17/12/2023',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            color: 
                                             widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          'RP. 20.000.000',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                             widget.color
                                            ?
                                            Color.fromARGB(255,197,18,19)
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        ),
                                    )
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    decoration: BoxDecoration(
                                    color: 
                                    widget.color
                                    ?
                                    Color.fromARGB(255,190,215,44)
                                    :
                                    Color.fromARGB(255, 255, 207, 228),
                                    borderRadius: BorderRadius.circular(20)
                                    ),
                                    height: 70,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          IconlyBold.bag,
                                          color: 
                                          widget.color
                                          ?
                                          Color.fromARGB(255,197,18,19)
                                          :
                                          Color.fromARGB(255,82,74,156),
                                          size: 28,
                                        ),
                                        title: Text(
                                          'Tropikana Drink',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                            widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '17/12/2023',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            color: 
                                             widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          'RP. 20.000.000',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                             widget.color
                                            ?
                                            Color.fromARGB(255,197,18,19)
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        ),
                                    )
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    decoration: BoxDecoration(
                                    color: 
                                    widget.color
                                    ?
                                    Color.fromARGB(255,190,215,44)
                                    :
                                    Color.fromARGB(255, 255, 207, 228),
                                    borderRadius: BorderRadius.circular(20)
                                    ),
                                    height: 70,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          IconlyBold.bag,
                                          color: 
                                          widget.color
                                          ?
                                          Color.fromARGB(255,197,18,19)
                                          :
                                          Color.fromARGB(255,82,74,156),
                                          size: 28,
                                        ),
                                        title: Text(
                                          'Tropikana Drink',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                            widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '17/12/2023',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            color: 
                                             widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          'RP. 20.000.000',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                             widget.color
                                            ?
                                            Color.fromARGB(255,197,18,19)
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        ),
                                    )
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    decoration: BoxDecoration(
                                    color: 
                                    widget.color
                                    ?
                                    Color.fromARGB(255,190,215,44)
                                    :
                                    Color.fromARGB(255, 255, 207, 228),
                                    borderRadius: BorderRadius.circular(20)
                                    ),
                                    height: 70,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          IconlyBold.bag,
                                          color: 
                                          widget.color
                                          ?
                                          Color.fromARGB(255,197,18,19)
                                          :
                                          Color.fromARGB(255,82,74,156),
                                          size: 28,
                                        ),
                                        title: Text(
                                          'Tropikana Drink',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                            widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '17/12/2023',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            color: 
                                             widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          'RP. 20.000.000',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                             widget.color
                                            ?
                                            Color.fromARGB(255,197,18,19)
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        ),
                                    )
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    decoration: BoxDecoration(
                                    color: 
                                    widget.color
                                    ?
                                    Color.fromARGB(255,190,215,44)
                                    :
                                    Color.fromARGB(255, 255, 207, 228),
                                    borderRadius: BorderRadius.circular(20)
                                    ),
                                    height: 70,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          IconlyBold.bag,
                                          color: 
                                          widget.color
                                          ?
                                          Color.fromARGB(255,197,18,19)
                                          :
                                          Color.fromARGB(255,82,74,156),
                                          size: 28,
                                        ),
                                        title: Text(
                                          'Tropikana Drink',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                            widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          '17/12/2023',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            color: 
                                             widget.color
                                            ?
                                            Colors.black
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          'RP. 20.000.000',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15, 
                                            fontWeight: FontWeight.bold,
                                            color: 
                                             widget.color
                                            ?
                                            Color.fromARGB(255,197,18,19)
                                            :
                                            Color.fromARGB(255,82,74,156),),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        ),
                                    )
                                  ),
                                                            
                                    
              ],
            ),
            
          ]),
        ],
      ),
    );
  }
}
