import 'package:ai_test_app/controllers/upload_gallery_images/upload_gallery_controller.dart';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';

import '../../controllers/open_camera_controller/open_camera_controller.dart';




class OpenCameraScreen extends StatelessWidget {
  const OpenCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CameraScreenController controller=Get.put(CameraScreenController());
    return  Scaffold(
        body: Center(
          child: GetX<CameraScreenController>(
            builder: (controller) {
              if (!controller.isCameraReady.value) {
                return const CircularProgressIndicator();
              } else {
                return AspectRatio(
                  aspectRatio: controller.controller.value.aspectRatio,
                  child: CameraPreview(controller.controller),
                );
              }
            },
          ),
        ),

        floatingActionButton:controller.saveButtonShow.value==true? FloatingActionButton(
          onPressed: () {
            controller.takePicture();
          },
          child: const Icon(Icons.camera),
        ):const SizedBox(),
    );
  }
}
