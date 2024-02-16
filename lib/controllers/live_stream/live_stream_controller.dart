import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ai_test_app/controllers/upload_gallery_images/upload_gallery_controller.dart';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';

class LiveStreamController extends GetxController{


  late CameraController controller;
  late Future<void> initializeControllerFuture;

  RxBool isCameraReady = false.obs;


  String selectedImagesBase64="";

  int counter=0;

  final MethodChannel channel = const MethodChannel('runScript');

  RxList<Map<String, dynamic>> detectedUserData = <Map<String, dynamic>>[].obs;
  String bufferFrame="";



  @override
  void onInit() async{

    await initializeCamera();
    // TODO: implement onInit
    super.onInit();
  }

//Initialize camera
  Future<void> initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();

    controller = CameraController(cameras[0], ResolutionPreset.low,);
    initializeControllerFuture = controller.initialize();
    controller.setFlashMode(FlashMode.off);


    controller.addListener(() async {
      counter++;
      if (controller.value.isInitialized) {
        isCameraReady.value = true;
        print("camera working");

        capturePicturesFrame();
        if(counter%5==0){
          print("Lenght of list--------------${detectedUserData.length}");

         await callKotlinFunction();
          print("Calling model");
        }



      } else {
        isCameraReady.value = false;
      }

    });
  }


  //Capture realtime frame
  Future<void> capturePicturesFrame() async {
    try {
      //await initializeControllerFuture; // Wait for the controller to be initialized

      if (controller.value.isInitialized) {
        XFile picture = await controller.takePicture();

        // Read the image file as bytes
        List<int> imageBytes = await File(picture.path).readAsBytes();

        // Encode the image bytes as base64
        String base64Image = base64Encode(imageBytes);

        // Now, you have the real-time frame as a base64-encoded string (base64Image)
        // You can use or process this base64Image as needed

        // Optionally, add the base64Image to your list or perform other actions
        selectedImagesBase64=base64Image;
        //print("Selected images-------------${selectedImagesBase64}");

        //Get.snackbar('Success', 'Real-time frame captured as base64.');
      } else {
        Get.snackbar('Error', 'Camera is not initialized.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error capturing image: $e');
      }
    }
  }



  //Kotlin call
  Future<void> callKotlinFunction() async {
    try {
      detectedUserData.clear();
      var pythonString = await channel.invokeMethod('cameraCall',selectedImagesBase64);
      Get.log('Result from Kotlin: $pythonString');
      List temp=pythonString.split(",");
      bufferFrame=temp[0].toString();
      print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk $bufferFrame");

      // Extract the JSON-like substring
      int startIndex = pythonString.indexOf("[{");
      int endIndex = pythonString.lastIndexOf("}]");

      if (startIndex != -1 && endIndex != -1 && endIndex > startIndex) {
        String jsonSubstring = pythonString.substring(startIndex, endIndex + 2);

        // Replace single quotes with double quotes for valid JSON
        jsonSubstring = jsonSubstring.replaceAll("'", '"');

        // Parse the JSON-like string into a Dart dynamic object
        var decodedObject = json.decode(jsonSubstring);

        if (decodedObject is List) {
          // Check if the decoded object is a list
          detectedUserData.assignAll(List<Map<String, dynamic>>.from(decodedObject));
          // Iterate over the list of maps
          for (Map<String, dynamic> myMap in detectedUserData) {
            // Print values for each map
            print("Name=============: ${myMap["name"]}");
            print("Refer===================: ${myMap["ref_no"]}");
            // Add more key access as needed
          }
          update();
        } else {
          print("Invalid input format: Expected a list");
        }
      } else {
        print("User list is empty");
      }


    } on PlatformException catch (e) {
      print('Error on conversion: ${e.message}');
    }
  }



  @override
  void onClose() {
    if (kDebugMode) {
      print("camera disposer call");
    }
    controller.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}