import 'dart:convert';

import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:serious_python/serious_python.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class MatchDataBaseController extends GetxController {
  final MethodChannel channel = const MethodChannel('runScript');

  @override
  void onInit() async {
    // await requestStoragePermission();
    // await runPythonScript();
    await checkFileSystemPermission();
    await callKotlinFunction();

    // await runPythonScript();
    // TODO: implement onInit

    //await invokeNativeMethod();
    super.onInit();
  }


  Future<void> checkFileSystemPermission() async {
    // Check if the app has permission to read external storage
    PermissionStatus status = await Permission.storage.status;

    if (status.isGranted) {
      // Permission has been granted, you can proceed with file system operations
      print("Storage permission is granted");
    } else {
      // Permission has not been granted, request it
      status = await Permission.storage.request();

      if (status.isGranted) {
        // Permission granted after request
        print("Storage permission granted after request");

      } else {
        // Permission denied, handle accordingly
        print("Storage permission denied");
      }
    }
  }



  Future<void> callKotlinFunction() async {
    try {
      final String result = await channel.invokeMethod('your_native_method',);
      print('Result from Kotlin: $result');
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
    }
  }

  Future<void> requestStoragePermission() async {
    // Request external storage read and write permissions
    var status = await Permission.storage.request();
    if (status.isGranted) {
      print("Storage permission granted");
    } else {
      print("Storage permission denied");
    }
  }

  Future<void> runPythonScript() async {
    try {
      ByteData scriptData = await rootBundle.load('assets/app/main.zip');
      Uint8List scriptContent = scriptData.buffer.asUint8List();

      // Convert binary data to base64-encoded string
      String base64String = base64Encode(scriptContent);

      // Pass the base64-encoded string to the run method
      var temp = await SeriousPython.run(base64String, appFileName: "main.py");

      print("temp-----------------------${temp}");
    } catch (error) {
      print('Error running Python script: $error');
    }
  }

// Future<int> addNumbers(int a, int b) async {
//   final python = ChaquopyPython();
//   final result = await python.execute('add_numbers', [a, b]);
//   return result as int;
// }
}
