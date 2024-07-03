part of 'import.dart';

class RamayanaCentralApprovalList extends StatefulWidget {
  const RamayanaCentralApprovalList({Key? key}) : super(key: key);

  @override
  State<RamayanaCentralApprovalList> createState() => _RamayanaCentralApprovalListState();
}

class _RamayanaCentralApprovalListState extends State<RamayanaCentralApprovalList> {
  // Widget Support
    // untuk action didalam appbar
    Widget historyButton() {
      return IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications),
        color: Colors.white,
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(const RamayanaCentralApprovalMenu(), 'Central Approval', historyButton, context),
      body: Column(
        children: [
          listTileCustom('PO00001293919921 - Seal', 'David Khu Husin | Senin, 17 April 2024', Icons.document_scanner, context)
        ],
      )
    );
  }
}
