part of 'import.dart';

class RamayanaMembercardHistoryY extends StatefulWidget {
  const RamayanaMembercardHistoryY({super.key, required this.color});
  final bool color;

  @override
  State<RamayanaMembercardHistoryY> createState() => _RamayanaMembercardHistoryYState();
}

class _RamayanaMembercardHistoryYState extends State<RamayanaMembercardHistoryY> {
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
                  margin: EdgeInsets.fromLTRB(20, 40, 20, 30),
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
                                        onTap: () {
                                          Navigator.push(
                                          context, MaterialPageRoute(builder: 
                                          (context){
                                            return RamayanaMembercardHistoryM(color: widget.color,);
                                          }));
                                        },
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
                                          '2024',
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
                                        onTap: () {
                                          Navigator.push(
                                          context, MaterialPageRoute(builder: 
                                          (context){
                                            return RamayanaMembercardHistoryM(color: widget.color,);
                                          }));
                                        },
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
                                          '2023',
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
                                        onTap: () {
                                          Navigator.push(
                                          context, MaterialPageRoute(builder: 
                                          (context){
                                            return RamayanaMembercardHistoryM(color: widget.color,);
                                          }));
                                        },
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
                                          '2022',
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
                                        onTap: () {
                                          Navigator.push(
                                          context, MaterialPageRoute(builder: 
                                          (context){
                                            return RamayanaMembercardHistoryM(color: widget.color,);
                                          }));
                                        },
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
                                          '2021',
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
                                        onTap: () {
                                          Navigator.push(
                                          context, MaterialPageRoute(builder: 
                                          (context){
                                            return RamayanaMembercardHistoryM(color: widget.color,);
                                          }));
                                        },
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
                                          '2020',
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