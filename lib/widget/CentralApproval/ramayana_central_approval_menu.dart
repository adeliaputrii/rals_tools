part of 'import.dart';

class RamayanaCentralApprovalMenu extends StatefulWidget {
  const RamayanaCentralApprovalMenu({Key? key}) : super(key: key);

  @override
  State<RamayanaCentralApprovalMenu> createState() => _RamayanaCentralApprovalMenuState();
}

class _RamayanaCentralApprovalMenuState extends State<RamayanaCentralApprovalMenu> {

  // Widget Support
    // widget untuk membantu widget history / catatan waktu dalam approval
    Widget historyButton(){
      return IconButton(
        onPressed: () {},
        icon: const Icon(Icons.history),
        color: Colors.white,
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarCustom(const Ramayana(),'Central Approval', historyButton, context),
        body: Column(
          children: [
            expansionTileCustom('NONTRADE', 'Tersedia 2 Menu', Icons.shopping_cart, context)
          ],
        )
    );
  }
}
