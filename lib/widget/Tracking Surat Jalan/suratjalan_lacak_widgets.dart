part of 'import.dart';

class SJLacakWidgets extends StatelessWidget {
  const SJLacakWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget stepperListView(List<StepperItemData> stepperSJ) {
  return StepperListView(
    showStepperInLast: true,
    stepperData: stepperSJ,
    stepAvatar: (_, data) {
      final stepData = data as StepperItemData;
      return PreferredSize(
        preferredSize: const Size.fromRadius(20),
        child: CircleAvatar(backgroundImage: AssetImage('assets/sj_lacak_lacakpaket.png')),
      );
    },
    stepContentWidget: (_, data) {
      final stepData = data as StepperItemData;
      return Container(
        decoration: BoxDecoration(color: Color.fromARGB(179, 241, 241, 241), borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(
          10,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(7),
          title: Container(
            margin: EdgeInsets.only(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status',
                  style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                ),
                Container(
                  decoration: BoxDecoration(color: Color.fromARGB(255, 195, 0, 0), borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        stepData.content['status'] ?? '',
                        style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Icon(
                      IconlyLight.calendar,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                  Container(
                    width: 90,
                    child: Text(
                      'Tanggal',
                      style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      ': ' + stepData.content['date'] ?? '',
                      style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Icon(
                      IconlyLight.location,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                  Container(
                    width: 90,
                    child: Text(
                      'Lokasi',
                      style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      ': ' + stepData.content['site'] ?? '',
                      style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Icon(
                      IconlyLight.paper,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                  Container(
                    width: 90,
                    child: Text(
                      'Deskripsi',
                      style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      ': ' + stepData.content['description'] ?? '',
                      style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Icon(
                      IconlyLight.document,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                  Container(
                    width: 90,
                    child: Text(
                      'Note ',
                      style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      ': ' + stepData.content['remark'] ?? '',
                      style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: stepData.content['rcv_koli'] != null && stepData.content['rcv_koli'] != 0,
                child: Row(
                  children: [
                    const Expanded(
                      child: Icon(
                        IconlyLight.document,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                    Container(
                      width: 90,
                      child: Text(
                        'Jumlah Koli',
                        style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        ': ' + (stepData.content['rcv_koli'] ?? '-').toString() + '/' + (stepData.content['actual_koli'] ?? '-').toString(),
                        style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: stepData.content['missing_koli'] != null && stepData.content['missing_koli'] != '-',
                child: Row(
                  children: [
                    const Expanded(
                      child: Icon(
                        IconlyLight.document,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                    Container(
                      width: 90,
                      child: Text(
                        'Koli Hilang',
                        style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        ': ' + (stepData.content['missing_koli'] ?? '-'),
                        style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: stepData.content['missing_koli'] != null && stepData.content['missing_koli'] != '-',
                child: Row(
                  children: [
                    const Expanded(
                      child: Icon(
                        IconlyLight.document,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                    Container(
                      width: 90,
                      child: Text(
                        'LSPB',
                        style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        ': ' + (stepData.content['lspb'] ?? '-').toString(),
                        style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Expanded(
                    child: Icon(
                      IconlyLight.profile,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                  Container(
                    width: 90,
                    child: Text(
                      'Petugas',
                      style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      ':' + stepData.content['pic'] ?? '',
                      style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    },
    stepperThemeData: StepperThemeData(
      lineColor: Colors.red,
      lineWidth: 1,
    ),
    physics: const BouncingScrollPhysics(),
  );
}
