part of 'import.dart';

class SplashScreenRamayana extends StatefulWidget {
  const SplashScreenRamayana({super.key});

  @override
  State<SplashScreenRamayana> createState() => _SplashScreenRamayanaState();
}

class _SplashScreenRamayanaState extends State<SplashScreenRamayana> {

  bool isLoaded = false;
  bool needLogin= true;

  @override
  void initState() {
    super.initState();
    ApprovalReturnMenu.approvalmenu.clear();
    ApprovalReturnMenu.idcashmenu.clear();
    ApprovalIdcash.approvalidcash.clear();
deleteUserData();
    loadUserData();
  }

  Future<void> deleteUserData()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('username');
    pref.remove('waktuLogin');
    print('detele');
  }
  Future<void> loadUserData()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? valid_until = pref.getString("session_valid_until");
    String? username = pref.getString("username");
    if (username!=null){
      if(valid_until!=null){
        DateTime session_valid = DateTime.tryParse(valid_until)!;
        if(DateTime.now().isAfter(session_valid)){
          pref.clear();
          needLogin=true;
        }else{
          needLogin=false;
        }
        isLoaded=true;
      }
    }
    isLoaded=true;
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateWhere: isLoaded,
      navigateRoute: needLogin?RamayanaLogin():DefaultBottomBarController(child: Ramayana()), backgroundColor: Colors.white,
      linearGradient: const LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
          logoSize: 150,
          text: FadeAnimatedText(
          "",
          textStyle: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ), 
      ),
      imageSrc: "assets/rama(C).png",
    );
  }
}