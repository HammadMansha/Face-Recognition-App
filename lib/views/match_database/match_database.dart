import 'package:ai_test_app/controllers/match_database/match_database_controller.dart';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';

import '../../controllers/upload_gallery_images/upload_gallery_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/common_buttons/common_button.dart';
import '../../widgets/common_textstyle/common_text_style.dart';

class MatchDatabaseScreen extends StatelessWidget {
  const MatchDatabaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Match Data Base",
          style: CommonTextStyle.style7font16weight700white,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: bodyData(),
    );
  }

  bodyData() {
    UploadGalleryController uploadGalleryController =
        Get.put(UploadGalleryController());

    MatchDataBaseController matchDataBaseController=Get.put(MatchDataBaseController());

    return Obx(() {
      return SafeArea(
        child: uploadGalleryController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.black,
                  child: Form(
                    key: uploadGalleryController.formKey,
                    child: Column(
                      children: [
                        //----------------------------Section if image selected-------------------
                        Obx(() {
                          return uploadGalleryController.selectedImages.isEmpty
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    //---------------------------Selected Image View section-------------------
                                    SizedBox(
                                      height: Get.height / 3,
                                      width: Get
                                          .width, // To show images in particular area only
                                      child: GridView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: uploadGalleryController
                                            .selectedImages.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3
                                                // Horizontally only 3 images will show
                                                ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // TO show selected file
                                          return Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: FileImage(
                                                        uploadGalleryController
                                                                .selectedImages[
                                                            index]))),
                                            // child: Image.file(uploadGalleryController.selectedImages[index])
                                          ).marginSymmetric(
                                              horizontal: 5, vertical: 5);
                                          // If you are making the web app then you have to
                                          // use image provider as network image or in
                                          // android or iOS it will as file only
                                        },
                                      ),
                                    ),

                                    //----------------------Update database button-----------------------
                                    CommonButton(
                                      fillColor: Colors.transparent,
                                      height: 55,
                                      width: Get.width,
                                      text: "Match From data base",
                                      borderColor: AppColors.colorF2A9,
                                      textStyle:
                                          CommonTextStyle.font18weight7White,
                                      onPressed: () async {
                                        // final result = await matchDataBaseController.runPythonScript();
                                        // print("python file result is----------$result");

                                      },
                                    ).marginOnly(top: 40),
                                  ],
                                );
                        }),

                        //---------------------Camera and  Image Button------------------

                        Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Get.toNamed(Routes.openCameraScreen,arguments: {
                                    "forSave":false,
                                  });
                                },
                                child: Container(
                                  height: 80,
                                  width: Get.width / 4.5,
                                  decoration: BoxDecoration(
                                    color: AppColors.colorF2A9,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child:
                                      Image.asset("assets/images/camera.png"),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  uploadGalleryController.getImages();
                                },
                                child: Container(
                                  height: 80,
                                  width: Get.width / 4.5,
                                  decoration: BoxDecoration(
                                    color: AppColors.colorF2A9,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child:
                                      Image.asset("assets/images/gallery.png"),
                                ),
                              ),
                            ],
                          ).marginOnly(
                              top:
                                  uploadGalleryController.selectedImages.isEmpty
                                      ? Get.height / 2.5
                                      : 40);
                        }),
                      ],
                    ).marginSymmetric(horizontal: 20),
                  ),
                ),
              ),
      );
    });
  }
}
