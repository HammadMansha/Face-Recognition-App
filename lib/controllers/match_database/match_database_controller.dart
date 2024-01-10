import 'dart:io';

import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:process_run/process_run.dart';
import 'package:serious_python/serious_python.dart';
import 'package:permission_handler/permission_handler.dart';

class MatchDataBaseController extends GetxController {
  @override
  void onInit() async {
    await requestStoragePermission();
    await runPythonScript();

    // await runPythonScript();
    // TODO: implement onInit
    super.onInit();
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
    // Replace '/path/to/python' and 'sample.py' with the actual path to your Python executable and script

final pythonExecutable = 'C:${Platform.pathSeparator}users${Platform.pathSeparator}hp${Platform.pathSeparator}appdata${Platform.pathSeparator}local${Platform.pathSeparator}programs${Platform.pathSeparator}python${Platform.pathSeparator}python39${Platform.pathSeparator}python.exe';
final pythonScript = 'C:${Platform.pathSeparator}Users${Platform.pathSeparator}HP${Platform.pathSeparator}Documents${Platform.pathSeparator}practise${Platform.pathSeparator}Face-Recognition-App${Platform.pathSeparator}sample.py';





if (await File(pythonExecutable).exists() && await File(pythonScript).exists()) {
  final process = await Process.run(pythonExecutable, [pythonScript]);
  // Rest of your code...
} else {
  print('Python executable or script not found.');
}

    // Print the output and exit code
    // print('Exit code: ${process.exitCode}');
    // print('Output: ${process.stdout}');
    // print('Error: ${process.stderr}');
  } catch (e) {
    print('Error executing Python script: $e');
  }
}

}
