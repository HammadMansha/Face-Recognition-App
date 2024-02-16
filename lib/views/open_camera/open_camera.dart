import 'dart:convert';

import 'package:ai_test_app/controllers/upload_gallery_images/upload_gallery_controller.dart';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';

import '../../controllers/open_camera_controller/open_camera_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/common_textstyle/common_text_style.dart';




class OpenCameraScreen extends StatelessWidget {
  const OpenCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CameraScreenController controller=Get.put(CameraScreenController());
    return  Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){

            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Camera",
          style: CommonTextStyle.style7font16weight700white,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),

      body:
           Center(
              child: GetX<CameraScreenController>(
                builder: (controller) {
                  if (!controller.isCameraReady.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: AspectRatio(
                        aspectRatio: controller.controller.value.aspectRatio,
                        child: CameraPreview(controller.controller),
                      ),
                    );
                  }
                },
              ),
            ),



        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.takePicture();
          },
          child: const Icon(Icons.camera),
        ),
    );
  }
}
