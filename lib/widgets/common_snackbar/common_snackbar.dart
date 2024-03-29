import 'dart:ui';


import '../../constants/app_colors/app_colors.dart';
import '../../utils/libraries/app_libraries.dart';
import '../common_textstyle/common_text_style.dart';

class CustomSnackBar {
  static void showSnackBar({
    required String title,
    required String message,
     Color backgroundColor=AppColors.allButtonsColor,
    bool isWarning = false,
  }) {
    Get.snackbar(title, message,
        padding: const EdgeInsets.all(0),
        snackPosition: SnackPosition.TOP,
        backgroundColor: backgroundColor,
        titleText: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            isWarning
                ? title == 'You are offline. Please connect to the internet.'
                ? Image.asset('assets/images/nowifi.png')
                : Container(
              height: 23.0,
              width: 23.0,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: const Icon(
                Icons.warning,
                color: Color(0xff22B161),
                size: 18.0,
              ),
            )
                : Container(
              height: 23.0,
              width: 23.0,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: const Icon(
                Icons.done,
                color: Color(0xff22B161),
                size: 18.0,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Flexible(
              child: Text(
                title,
                textScaleFactor: 1.0,
                style: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.4),
              ),
            )
          ],
        ).marginOnly(top: 18.0, left: 10.0),
        messageText: Text(
          message,
          style:CommonTextStyle.font15weight500white,
        ).marginAll(10),
        colorText: Colors.white,
        borderRadius: 8,
        margin: const EdgeInsets.all(10));
  }
}
