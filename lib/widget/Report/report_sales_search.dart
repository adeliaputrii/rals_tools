part of 'import.dart';

class SearchInputReport extends StatelessWidget {
  TextEditingController controller;
  final void Function(String) onSelectedCallback;
  SearchInputReport({super.key, required this.controller, required this.onSelectedCallback});

  List<String> titleReport = [];

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      margin: EdgeInsets.fromLTRB(20, 0, 10, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: 
      TextFormField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onChanged: (text) {
        onSelectedCallback(text);
      },
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(IconlyLight.search,
        color: baseColors.primaryColor,
        size: 20,
        ),
        border: InputBorder.none,
        hintText: 'Search',
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black
          )
        ),
      ),
    );
  }
}
