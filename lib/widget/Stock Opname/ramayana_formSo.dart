part of 'import.dart';

class RamayanaSo extends StatefulWidget {
  const RamayanaSo({super.key});

  @override
  State<RamayanaSo> createState() => _RamayanaSoState();
}

class _RamayanaSoState extends State<RamayanaSo> {

  TextEditingController _controllerLocationApi = TextEditingController();
  TextEditingController _controllerLocation = TextEditingController();
  TextEditingController _controllerSku = TextEditingController();
  TextEditingController _controllerJumlah = TextEditingController();

  List<Item> items = [];
  String _location = '';

  late PopUpWidget popUpWidget;

  Future<void> scanBarcodeScan(
    TextEditingController controller
  ) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeScanRes == '-1') {
        popUpWidget.showPopUpError(notFound, 'Barcode tidak terdeteksi');
      } else {
        controller.text = barcodeScanRes;
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      if (!mounted) return;
      setState(() {
        controller.text = barcodeScanRes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    popUpWidget = PopUpWidget(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: baseColor.primaryColor,
        leading: IconButton(
          onPressed: (){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
              builder: (context) =>
              DefaultBottomBarController(child: Ramayana()),
              ),
              (Route<dynamic> route) => false);
              }, 
            icon: Icon(Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            )
          ),
        centerTitle: true,
        title: Text('Stock Opname',
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: screenHeight/3.8,
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70)
                  ),
                  color: baseColor.primaryColor,
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/soanimasi.png'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: screenHeight/3.8
                  ),
                  height: 100,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                  ),
                  color: baseColor.primaryColor,
                  ),
                ),
                Container(
                  width: screenWidth,
                  margin: EdgeInsets.only(
                    top: screenHeight/3.8
                  ),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                  topRight: Radius.circular(70)
                  ),
                  color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Form Stock Opname',
                         style: GoogleFonts.plusJakartaSans(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                         ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20,bottom: 10),
                          child: Text('No. Location',
                          style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                         ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 241, 241),
                          borderRadius: BorderRadius.circular(15)
                          ),
                          child: TextFormField(
                            controller: _controllerLocationApi,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_pin,
                              color: baseColor.primaryColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  scanBarcodeScan(_controllerLocation);
                                },
                                icon: Icon(Icons.qr_code,
                                color: baseColor.primaryColor,
                                ),
                                ),
                              hintText: 'Scan or Write here',
                              hintStyle: GoogleFonts.plusJakartaSans(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.black, // Set the border color
                                  width: 1.5, // Set the border width
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.black, // Set the border color
                                  width: 1.5, // Set the border width
                                ),
                              ),
                            ),
                          ),
                        ),
                        _controllerLocationApi == null
                        ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20,bottom: 10),
                              child: Text('No. Location',
                              style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                             ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 241, 241),
                              borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                controller: _controllerLocation,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.location_pin,
                                  color: baseColor.primaryColor,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      scanBarcodeScan(_controllerLocation);
                                    },
                                    icon: Icon(Icons.qr_code,
                                    color: baseColor.primaryColor,
                                    ),
                                    ),
                                  hintText: 'Scan or Write here',
                                  hintStyle: GoogleFonts.plusJakartaSans(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      color: Colors.black, // Set the border color
                                      width: 1.5, // Set the border width
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      color: Colors.black, // Set the border color
                                      width: 1.5, // Set the border width
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                    child: Text('No. SKU',
                                    style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                    ),),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 243, 241, 241),
                                    borderRadius: BorderRadius.circular(15)
                                    ),
                                    width: screenWidth/2,
                                    child: TextFormField(
                                      controller: _controllerSku,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.local_offer,
                                        color: baseColor.primaryColor,
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            scanBarcodeScan(_controllerSku);
                                          },
                                          icon: Icon(Icons.qr_code,
                                          color: baseColor.primaryColor,
                                          ),
                                          ),
                                        hintText: 'Scan or Write here',
                                        hintStyle: GoogleFonts.plusJakartaSans(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                            color: Colors.black, // Set the border color
                                            width: 1.5, // Set the border width
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                            color: Colors.black, // Set the border color
                                            width: 1.5, // Set the border width
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                  padding: const EdgeInsets.only(top:17,bottom: 3),
                                    child: Text('Jumlah',
                                    style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                    )),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color.fromARGB(255, 243, 241, 241),
                                        ),
                                        width: screenWidth/4,
                                        child: TextFormField(
                                          controller: _controllerJumlah,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.shopping_cart,
                                            color: baseColor.primaryColor,
                                            ),
                                            hintText: '.....',
                                            hintStyle: GoogleFonts.plusJakartaSans(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                              borderSide: BorderSide(
                                                color: Colors.black, // Set the border color
                                                width: 1.5, // Set the border width
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                              borderSide: BorderSide(
                                                color: Colors.black, // Set the border color
                                                width: 1.5, // Set the border width
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                      children: [
                                        MaterialButton(
                                          minWidth: 10,
                                          onPressed: (){
                                            if(_controllerSku.text.isEmpty || _controllerJumlah.text.isEmpty) {
                                              popUpWidget.showPopUpError('Plese Enter', 'Enter SKU & Quantity');
                                            } else {
                                            setState(() {
                                            _location = _controllerLocation.text;
                                            items.add(Item(
                                              sku: _controllerSku.text, 
                                              location: _controllerLocation.text,
                                              jumlah: _controllerJumlah.text
                                              ));
                                            _controllerSku.clear();
                                            _controllerJumlah.clear();
                                            });
                                          }
                                          },
                                          child: CircleAvatar(
                                            child: Icon(Icons.add,
                                            color: Colors.white,),
                                            backgroundColor: baseColor.primaryColor,
                                          ),
                                        ),
                                        Text('Add SKU')
                                      ],
                                    )
                                    ],
                                  ),
                                ],
                                ),
                              ],
                            ),
                            Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: Text('Summary',
                               style: GoogleFonts.plusJakartaSans(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                               ),
                              ),
                                                  ),
                                                  Container(
                            margin: EdgeInsets.only(bottom: 30),
                            width: screenWidth,
                            height: 
                            items.length == 0 
                            ?
                            screenHeight/4
                            :
                            screenHeight/2,
                            decoration: BoxDecoration(
                            color: baseColor.grey,
                            borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                                  child: Text('Location ${_location}',
                                  style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                  ),
                                  ),
                                ),
                                Flexible(child: 
                                ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                  return Container(
                                  width: screenWidth,
                                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                            child: Text('${items[index].sku}',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                                            child: Text('Jumlah ${items[index].jumlah}',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 15,
                                              color: Colors.black
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          setState(() {
                                           items.removeAt(index);
                                          });
                                        }, 
                                        icon: Icon(Icons.close))
                                      ],
                                    ),
                                  );
                                  },)
                                )
                              ],
                            ),
                            ),
                            MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            minWidth: screenWidth,
                            color: baseColor.primaryColor,
                            onPressed: () {
                              setState(() {
                                items.removeRange(0, items.length);
                                _location = '';
                                _controllerLocation.clear();
                              });
                            },
                            child: Text('CLEAR',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                              ),
                            ),
                            ),
                            MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            minWidth: screenWidth,
                            color: baseColor.primaryColor,
                            onPressed: () {
                              items.removeRange(0, items.length);
                              _location = '';
                              _controllerLocation.clear();
                            },
                            child: Text('SUBMIT',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                              ),
                            ),
                                                  ),
                          ],
                        )
                        :
                        Container()
                      ],
                    ),
                  ),
                ),
              ],),
          ],
        ),
      ),
    );
  }
}

class Item {
  String sku;
  String? location;
  String jumlah;

  Item({required this.sku, this.location, required this.jumlah});
}