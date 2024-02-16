import 'dart:convert';

import 'package:ai_test_app/controllers/live_stream/live_stream_controller.dart';
import 'package:ai_test_app/controllers/upload_gallery_images/upload_gallery_controller.dart';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';

import '../../controllers/open_camera_controller/open_camera_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/common_textstyle/common_text_style.dart';




class LiveStreamView extends StatelessWidget {
  const LiveStreamView({super.key});

  @override
  Widget build(BuildContext context) {
    final LiveStreamController controller=Get.put(LiveStreamController());
    return  Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            controller.onClose();
            controller.dispose();
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Live Stream",
          style: CommonTextStyle.style7font16weight700white,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),

      body: Obx(() {
        return Stack(
          children: [
            Center(
              child: GetX<LiveStreamController>(
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
            SingleChildScrollView(
              child: Column(
                children: [


                  SizedBox(
                    height: Get.height,
                    width: 150,
                    child: ListView.builder(
                      itemCount:controller.detectedUserData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 150,
                          width: 150,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Name
                              Row(
                                children: [
                                  Text("Name : ",style: CommonTextStyle.font10weight300F8FAPublic),
                                  Text("${controller.detectedUserData[index]["name"]}",style: CommonTextStyle.font10weight300F8FAPublic,overflow: TextOverflow.ellipsis,),

                                  //Text("${controller.detectedUserData[0]["name"]}"),




                                  //Text("${controller.detectedUserData[0]["name"]}"),




                                  //Text("${controller.detectedUserData[0]["name"]}"),

                                ],
                              ),
                              //Refer No
                              Row(
                                children: [
                                  Text("Ref_No : ",style: CommonTextStyle.font10weight300F8FAPublic,overflow: TextOverflow.ellipsis,),
                                  Text("${controller.detectedUserData[index]["ref_no"]}",style: CommonTextStyle.font10weight300F8FAPublic,overflow: TextOverflow.ellipsis,),
                                ],
                              ),

                              Text("Picture :",style: CommonTextStyle.font10weight300F8FAPublic,overflow: TextOverflow.ellipsis,),

                              GestureDetector(
                                onTap: (){

                                  Get.toNamed(Routes.recordScreen,arguments: {
                                    "name":controller.detectedUserData[index]["name"],
                                    "ref":controller.detectedUserData[index]["ref_no"],
                                    "summary":controller.detectedUserData[index]["Summary"],
                                    "image":controller.detectedUserData[index]["image_bytes"],
                                  });
                                  controller.dispose();
                                },
                                child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child:Image.memory(base64Decode(controller.detectedUserData[index]["image_bytes"])),
                                ),
                              ),
                            ],
                          ),
                        );

                      },
                    ),
                  ),





                ],
              ),
            ),
          ],
        );
      }
      ),
    );
  }
}
