part of 'API_service.dart';

class AuthServicesLog {
  static Future<http.Response> login(
    String user_name,
    String password,
    String progname,
    String versi,
    String date_run,
    String info1,
    String info2,
    String userid,
    String toko,
    String devicename,
    String imei,
    //  String device_id
  ) async {
    print('damn 88');
    print(imei);
    Map data = {
      'user_name': user_name,
      'password': password,
      // 'progname': progname,
      // 'versi': versi,
      // 'date_run': date_run,
      // 'info1': info1,
      // 'info2': info2,
      // 'userid': userid,
      // 'toko': toko,
      // 'devicename': devicename,
      // 'imei': imei,
      'device_id': 'samsung',
    };
    print('damn 555');
    print(data);
    var body = json.encode(data);
    var url = Uri.parse(tipeurl + 'api/v1/auth/signin');
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      // Request was successful
      print("Request successful");
      // You can access the response body using response.body
    } else {
      // Request failed
      print("Request failed with status: ${response.statusCode}");
      print("Response body: ${response.body}");
      // Handle the failure, e.g., show an error message to the user
    }
    final sharedPref = await SharedPreferences.getInstance();
    final myMapsPref = json.encode({
      'user_name': user_name,
    });

    sharedPref.setString('authData', myMapsPref);
    print('cingcai 111');
    print(response.body);
    print('adel cantik');
    return response;
  }
}
