import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';


class UploadGalleryController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController ref = TextEditingController();
  TextEditingController summary = TextEditingController();

  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();

  List<CameraDescription>? cameras;
  String imagePath = "";
  RxBool isLoading=false.obs;
  int framesPerSecond = 5;


  RxList<File> selectedImages = RxList<File>();
  RxList<String> base64Images = <String>[].obs;
  final MethodChannel channel = const MethodChannel('runScript');
  Map<String, dynamic> data = {};
   late bool arePermissionsGranted;
  @override
  void onInit() async{
    // TODO: implement onInit
    await askForPermissions();
    super.onInit();
  }


  Future<bool> checkPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus storageStatus = await Permission.storage.status;
    update();

    return cameraStatus == PermissionStatus.granted && storageStatus == PermissionStatus.granted;
  }

  Future<void> requestPermissions() async {
    await Permission.camera.request();
    await Permission.storage.request();
    update();
  }

  Future<void> askForPermissions() async {
     arePermissionsGranted = await checkPermissions();
     update();
    print("========================$arePermissionsGranted");
    if (!arePermissionsGranted) {
      await requestPermissions();
      update();
    }
    update();
  }

  //Add data in a map
  void updateData() {

    data = Map<String, dynamic>.from({
      "name": name.text,
      "ref": ref.text,
      "summary": summary.text,
      "images": base64Images.toList(),
    });



  }


//Kotlin call
  Future<void> callKotlinFunction() async {
    try {
      isLoading.value=true;
      var result = await channel.invokeMethod('your_native_method',data);
      print('Result from Kotlin: $result');
      isLoading.value=false;
      if(result.toString().contains("Hello")){
        name.clear();
        ref.clear();
        summary.clear();
        selectedImages.clear();
        Get.snackbar("Success", "Uploaded successfully");
      }
      else{
        Get.snackbar("Warning", "Something went wrong");

      }

    } on PlatformException catch (e) {
      isLoading.value=false;
      Get.snackbar("Warning", "Something went wrong try again");
      print('Error: ${e.message}');
    }
  }





  //function for select images
  Future<void> getImages() async {
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (pickedFiles.isNotEmpty) {
      for (var i = 0; i < pickedFiles.length; i++) {
        selectedImages.add(File(pickedFiles[i].path));

      }
      await convertImagesToBase64();
    }
    else {
      Get.snackbar("Warning", "Nothing is selected");
    }

    update();
  }

  //Save image to gallery

  Future<void> saveImagesToGallery() async {
    isLoading.value=true;
    Directory? galleryDirectory = await getExternalStorageDirectory();
    String nameValue = "${name.text.trim()}-${ref.text.trim()}-${summary.text.trim()}"; // Assuming 'name' is the TextEditingController for the user's name
    String peopleFolderPath = path.join(galleryDirectory!.path,'people', nameValue);
    Directory peopleDirectory = Directory(peopleFolderPath);

    if (!peopleDirectory.existsSync()) {
      peopleDirectory.createSync();
    }

    for (File image in selectedImages) {
      String imageName = path.basename(image.path);
      String newPath = path.join(peopleFolderPath, imageName);
      image.copySync(newPath);
      if (kDebugMode) {
        print("image path---------$newPath");
      }
    }
    name.clear();
    ref.clear();
    summary.clear();
    selectedImages.clear();
    isLoading.value=false;

    Get.snackbar('Success', 'Images saved to "$nameValue/People" folder in the gallery.');
  }


  //Convert selected images into base64


  Future<void> convertImagesToBase64() async {
    List<String> base64Strings = [];

    for (File image in selectedImages) {
      Uint8List imageBytes = await image.readAsBytes();
      String base64String = base64Encode(imageBytes);
      base64Strings.add(base64String);
    }

    base64Images.assignAll(base64Strings);
  }






}
