import 'package:ai_test_app/controllers/dashboard/dashboard_controller.dart';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:ai_test_app/widgets/common_buttons/common_button.dart';
import 'package:ai_test_app/widgets/common_textstyle/common_text_style.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../../routes/app_routes.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyData(context),
    );
  }

  bodyData(BuildContext context) {
    DashboardController dashboardController = Get.put(DashboardController());
    return Container(
      height: Get.height,
      width: Get.width,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height / 4,
          ),
          //----------------------Container section----------------------

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.uploadGallery);
                    },
                    child: Container(
                      height: 170,
                      width: Get.width / 2.5,
                      decoration: BoxDecoration(
                        color: AppColors.colorF2A9,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Image.asset("assets/images/upload.png"),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 2.5,
                    child: Text(
                      "Share captured moments from your gallery.",
                      style: CommonTextStyle.font14weight300White60,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ).marginOnly(top: 20),
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.matchDatabaseScreen);
                    },
                    child: Container(
                      height: 170,
                      width: Get.width / 2.5,
                      decoration: BoxDecoration(
                        color: AppColors.colorF2A9,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Image.asset("assets/images/live_stream.png"),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 2.5,
                    child: Text(
                      "Broadcast and share real-time moments with the world.",
                      style: CommonTextStyle.font14weight300White60,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ).marginOnly(top: 20),
                ],
              ),
            ],
          ),



        ],
      ),
    );
  }
}
