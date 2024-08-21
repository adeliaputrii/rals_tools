part of 'import.dart';

class SearchInputReport extends StatelessWidget {
  TextEditingController controller;
  final void Function(String) onSelectedCallback;
  SearchInputReport({super.key, required this.controller, required this.onSelectedCallback});

  List<String> titleReport = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      height: MediaQuery.of(context).size.height / 25,
      child: TextField(
        readOnly: false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 236, 236, 236),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 236, 236, 236),
            ), //<-- SEE HERE
            borderRadius: BorderRadius.circular(10.0),
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
          onSelectedCallback(text);
        },
      ),
    );
  }
}
