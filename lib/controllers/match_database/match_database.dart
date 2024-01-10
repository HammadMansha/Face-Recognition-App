import 'dart:io';

import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:process_run/process_run.dart';

class MatchDataBaseController extends GetxController{


  @override
  void onInit()async {
    await runPythonScript();
    // TODO: implement onInit
    super.onInit();
  }


   Future<String> runPythonScript() async {
     final pythonProcess = await Process.start(
       'python',
       ['sample.py'],
       workingDirectory: 'C:/Users/HP/Documents\practise\Face-Recognition-App', // Replace with the actual path
     );


     final output = await flutterProcessResultToOutput(pythonProcess);
    return output;
  }
}

Future<String> flutterProcessResultToOutput(Process process) async {
  final output = StringBuffer();
  process.stdout.transform(utf8.decoder).listen((data) {
    output.write(data);
  });

  process.stderr.transform(utf8.decoder).listen((data) {
    output.write(data);
  });

  final exitCode = await process.exitCode;
  return 'Exit Code: $exitCode\n\nOutput:\n$output';
}


