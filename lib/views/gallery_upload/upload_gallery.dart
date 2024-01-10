import 'package:ai_test_app/controllers/auth/login/login_controller.dart';
import 'package:ai_test_app/controllers/upload_gallery_images/upload_gallery_controller.dart';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:ai_test_app/widgets/common_textfields/commn_textfield.dart';
import 'package:ai_test_app/widgets/common_textstyle/common_text_style.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../routes/app_routes.dart';
import '../../widgets/common_buttons/common_button.dart';

class UploadFromGallery extends StatelessWidget {
  const UploadFromGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Upload",
          style: CommonTextStyle.style7font16weight700white,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: bodyData(),
    );


  }

  bodyData() {
    UploadGalleryController uploadGalleryController = Get.put(UploadGalleryController());
    LoginScreenController loginScreenController = Get.put(LoginScreenController());

    return Obx(() {
        return SafeArea(
          child: uploadGalleryController.isLoading.value==true?const Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
            child: Container(
              height: Get.height,
              width: Get.width,
              color: Colors.black,
              child: Form(
                key: uploadGalleryController.formKey,
                child: Column(
                  children: [

                    //---------------------------Name Row----------------------
                    Row(
                      children: [
                        Text(
                          "Name",
                          style: CommonTextStyle.font13weight400White,
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: CommonTextField(
                            fillcolor: Colors.white,
                            controller: uploadGalleryController.name,
                            bordercolor: AppColors.colorC9C9,
                            disableBorderColor: AppColors.colorC9C9,
                            textColor: Colors.black,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'This filed is required';
                              } else if (loginScreenController
                                  .isEmptyField(value.toString())) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 12,
                    ),
                    //---------------------------Ref row-----------------------
                    Row(
                      children: [
                        Text(
                          "Ref",
                          style: CommonTextStyle.font13weight400White,
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Expanded(
                          child: CommonTextField(
                            fillcolor: Colors.white,
                            controller: uploadGalleryController.ref,
                            bordercolor: AppColors.colorC9C9,
                            disableBorderColor: AppColors.colorC9C9,
                            textColor: Colors.black,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'This filed is required';
                              } else if (loginScreenController
                                  .isEmptyField(value.toString())) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    //---------------------Summary Row---------------------------
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Summary",
                          style: CommonTextStyle.font13weight400White,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: CommonTextField(
                            fillcolor: Colors.white,
                            controller: uploadGalleryController.summary,
                            bordercolor: AppColors.colorC9C9,
                            disableBorderColor: AppColors.colorC9C9,
                            maxLine: 7,
                            textColor: Colors.black,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'This filed is required';
                              } else if (loginScreenController
                                  .isEmptyField(value.toString())) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),

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
                                    itemBuilder: (BuildContext context, int index) {
                                      // TO show selected file
                                      return Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: FileImage(
                                                    uploadGalleryController
                                                        .selectedImages[index]))),
                                        // child: Image.file(uploadGalleryController.selectedImages[index])
                                      ).marginSymmetric(horizontal: 5, vertical: 5);
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
                                  text: "Save in data base",
                                  borderColor: AppColors.colorF2A9,
                                  textStyle: CommonTextStyle.font18weight7White,
                                  onPressed: () async{
                                    if (uploadGalleryController.formKey.currentState!.validate()) {
                                     await uploadGalleryController.saveImagesToGallery();

                                    }
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
                              onTap: ()async {
                                Get.toNamed(Routes.openCameraScreen);
                              },
                              child: Container(
                                height: 80,
                                width: Get.width / 4.5,
                                decoration: BoxDecoration(
                                  color: AppColors.colorF2A9,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Image.asset("assets/images/camera.png"),
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
                                child: Image.asset("assets/images/gallery.png"),
                              ),
                            ),
                          ],
                        ).marginOnly(
                            top: uploadGalleryController.selectedImages.isEmpty
                                ? Get.height / 2.5
                                : 40);
                      }

                    ),
                  ],
                ).marginSymmetric(horizontal: 20),
              ),
            ),
          ),
        );
      }
    );
  }
}
