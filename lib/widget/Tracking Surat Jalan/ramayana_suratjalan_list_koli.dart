part of 'import.dart';

class SJMissingColy extends StatefulWidget {
  SJMissingColy({super.key, required this.listColy});
  List<SuratJalanKoliModel> listColy;

  @override
  State<SJMissingColy> createState() => _SJMissingColyState();
}

class _SJMissingColyState extends State<SJMissingColy> {
  TextEditingController _searchController = TextEditingController();
  List<String> noColyMissing = [];
  List<SuratJalanKoliModel> searchNoColy = [];
  String searchQuery = '';
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    noColyMissing = getCheckedValue(widget.listColy);
  }

  void searchColy(String text) {
    setState(
      () {
        searchQuery = text;

        searchNoColy = widget.listColy
            .where(
              (item) => item.nomor.toLowerCase().contains(
                    text.toLowerCase(),
                  ),
            )
            .toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (true) {
          Navigator.pop(context);
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: baseColor.primaryColor,
          title: isSearch ? TextFieldInputSearch(_searchController) : Text('Pilih Nomor Koli Hilang'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: !isSearch ? Icon(Icons.search) : Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    isSearch = !isSearch;
                    _searchController.text = '';
                    searchNoColy.clear();
                  });
                })
          ],
        ),
        body: searchNoColy.isEmpty ? searchEmpty() : searchResult(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Container(
            height: 50,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context, noColyMissing);
              },
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  BorderSide(
                    color: baseColor.primaryColor, // Set the border color to red
                    width: 2.0, // Set the border width
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child: Text('Pilih (${getCheckedValue(widget.listColy).length})',
                  style: GoogleFonts.plusJakartaSans(fontSize: 18, color: baseColor.primaryColor)),
            ),
          ),
        ),
      ),
    );
  }

  Widget TextFieldInputSearch(TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      height: MediaQuery.of(context).size.height / 25,
      child: TextField(
        readOnly: false,
        keyboardType: TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 236, 236, 236),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 236, 236, 236),
            ), //<-- SEE HERE
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 236, 236, 236),
            ), //<-- SEE HERE
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onChanged: (text) {
          debugPrint('text' + text);
          searchColy(text);
        },
      ),
    );
  }

  List<String> getCheckedValue(List<SuratJalanKoliModel> list) {
    return list.where((element) => element.isChecked ?? false).map((e) => e.nomor).toList();
  }

  Widget searchResult() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: searchNoColy.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(
                      searchNoColy[index].nomor,
                      style: GoogleFonts.plusJakartaSans(fontSize: 17),
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: baseColor.primaryColor,
                      value: searchNoColy[index].isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          searchNoColy[index].isChecked = value;
                          noColyMissing.contains(searchNoColy[index].nomor)
                              ? noColyMissing.remove(searchNoColy[index].nomor)
                              : noColyMissing.add(searchNoColy[index].nomor);
                        });
                        debugPrint(noColyMissing.toString());
                      },
                    ),
                  ]),
                  Divider()
                ],
              ),
            ),
          );
        });
  }

  Widget searchEmpty() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.listColy.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(
                      widget.listColy[index].nomor,
                      style: GoogleFonts.plusJakartaSans(fontSize: 17),
                    ),
                    Checkbox(
                      value: widget.listColy[index].isChecked,
                      checkColor: Colors.white,
                      activeColor: baseColor.primaryColor,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.listColy[index].isChecked = value;
                          noColyMissing.contains(widget.listColy[index].nomor)
                              ? noColyMissing.remove(widget.listColy[index].nomor)
                              : noColyMissing.add(widget.listColy[index].nomor);
                        });
                        debugPrint(noColyMissing.toString());
                      },
                    ),
                  ]),
                  Divider()
                ],
              ),
            ),
          );
        });
  }
}
