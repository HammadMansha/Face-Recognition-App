import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ai_test_app/controllers/upload_gallery_images/upload_gallery_controller.dart';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';

class CameraScreenController extends GetxController{


  late CameraController controller;
  late Future<void> initializeControllerFuture;

  RxBool isCameraReady = false.obs;

  UploadGalleryController uploadGalleryController=Get.find<UploadGalleryController>();

  String selectedImagesBase64="";

  int counter=0;





  @override
  void onInit() async{

    await initializeCamera();
    // TODO: implement onInit
    super.onInit();
  }

//Initialize camera
  Future<void> initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();

    controller = CameraController(cameras[0], ResolutionPreset.medium,);
    initializeControllerFuture = controller.initialize();
    controller.setFlashMode(FlashMode.off);


    controller.addListener(() async {
      if (controller.value.isInitialized) {
        isCameraReady.value = true;
        print("camera working");


      } else {
        isCameraReady.value = false;
      }

    });
  }

//On click take image
  Future<void> takePicture() async {
    try {
      // await _initializeControllerFuture;
      XFile picture = await controller.takePicture();


      // Save the captured image to the gallery
      await GallerySaver.saveImage(picture.path, albumName: 'record');


      uploadGalleryController.selectedImages.add(File(picture.path));
      Get.snackbar('Success', 'Image captured and added to the list.');
    } catch (e) {
      if (kDebugMode) {
        print('Error capturing image: $e');
      }
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