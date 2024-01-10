import 'dart:io';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{

  final picker = ImagePicker();

  List<CameraDescription>? cameras;
  String imagePath = "";

  RxList<File> selectedImages = RxList<File>();






  @override
  void onInit() {
    super.onInit();
    //initializeCamera();
  }





  //-----------------Get images from gallery------------------
  Future<void> getImages() async {
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      for (var i = 0; i < pickedFiles.length; i++) {
        selectedImages.add(File(pickedFiles[i].path));
      }
    } else {
      Get.snackbar("Warning", "Nothing is selected");
    }

    update();
  }


  //----------------Capture image from camera-----------------





}