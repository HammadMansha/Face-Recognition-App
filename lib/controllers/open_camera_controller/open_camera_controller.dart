import 'dart:io';

import 'package:ai_test_app/controllers/upload_gallery_images/upload_gallery_controller.dart';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:gallery_saver/gallery_saver.dart';

class CameraScreenController extends GetxController{


  late CameraController controller;
  late Future<void> initializeControllerFuture;

  RxBool isCameraReady = false.obs;

  UploadGalleryController uploadGalleryController=Get.find<UploadGalleryController>();
RxBool saveButtonShow=true.obs;

  @override
  void onInit() async{
    if(Get.arguments!=null){

      saveButtonShow.value=Get.arguments["forSave"];
    }
    await initializeCamera();
    // TODO: implement onInit
    super.onInit();
  }


  Future<void> initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();

    controller = CameraController(cameras[0], ResolutionPreset.medium);
    initializeControllerFuture = controller.initialize();

    controller.addListener(() {
      if (controller.value.isInitialized) {
        isCameraReady.value = true;
      } else {
        isCameraReady.value = false;
      }
    });
  }


  Future<void> takePicture() async {
    try {
     // await _initializeControllerFuture;

      XFile picture = await controller.takePicture();

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


}