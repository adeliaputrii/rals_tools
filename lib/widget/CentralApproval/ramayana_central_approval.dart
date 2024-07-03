part of 'import.dart';

class RamayanaCentralApproval extends StatefulWidget {
  const RamayanaCentralApproval({Key? key}) : super(key: key);

  @override
  State<RamayanaCentralApproval> createState() => _RamayanaCentralApprovalState();
}

class _RamayanaCentralApprovalState extends State<RamayanaCentralApproval> {
  // Widget Support
    // untuk action didalam appbar
    Widget nofiticationButton() {
      return IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications),
        color: Colors.white,
      );
    }

    // user melakukan aksi dalam rejected atau approval
    Widget approval() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Rejected',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.w500
              ),),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Approved',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.w500
              ),),
          ),
        ],
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(const RamayanaCentralApprovalList(), 'Central Approval', nofiticationButton, context),
      body: viewPDF('update', approval, context),
    );
  }
}
