import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class GetFile {
  Future<File?> writeUUIDToFile() async {
    var tempDir = await getExternalStorageDirectory();
    final file = File('storage/emulated/0/DCIM/uuid.txt');
    // File file = File(tempDir!.path + '/uuid.txt');
    try {
      var uuid = Uuid();
      //   var genereateUuid = uuid.v4();
      //   final directory = await getApplicationDocumentsDirectory();
      //   final file =
      //       File('storage/emulated/0/DCIM/uuid.txt').create(recursive: true);
      //   // final file = File('${directory.path}/uuid.txt');
      debugPrint('file in ' + tempDir!.path + '/uuid.txt');
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeString(uuid.v4());
      await raf.close();
    } catch (e) {
      print('Error is: $e');
    }
    // try {
    //   var uuid = Uuid();
    //   var genereateUuid = uuid.v4();
    //   final directory = await getApplicationDocumentsDirectory();
    //   final file =
    //       File('storage/emulated/0/DCIM/uuid.txt').create(recursive: true);
    //   // final file = File('${directory.path}/uuid.txt');
    //   debugPrint('${directory.path}/uuid.txt');
    //   return file;
    // } catch (e) {
    //   debugPrint(e.toString());
    //   return null;
    // }

    // Encrypt the UUID or use any other security measures if needed
    // Here, we are just writing it directly for demonstration purposes.
  }

  Future<String?> readUUIDFromFile() async {
    try {
      final directory = await getExternalStorageDirectory();
      final file = File('storage/emulated/0/DCIM/uuid.txt');

      // Read the content of the file
      String contents = await file.readAsString();

      // Decrypt or process the content if needed
      // Here, we assume the content is the UUID.
      debugPrint('the uuuid is' + contents);
      return contents;
    } catch (e) {
      // Handle file read errors
      return null;
    }
  }
}
