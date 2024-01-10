import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:ai_test_app/widgets/common_buttons/common_button.dart';
import 'package:ai_test_app/widgets/common_textstyle/common_text_style.dart';

import '../../routes/app_routes.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyData(),
    );
  }

  bodyData() {
    return SafeArea(
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration:const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/splash_screen.png",),

          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CommonButton(
                fillColor: AppColors.colorF2A9,
                onPressed: (){
                  Get.toNamed(Routes.loginScreen);
                },
              text: "Lets Start",
              width: Get.width/1.2,
              height: 48,
              textStyle: CommonTextStyle.font16weight400Black50,
            ).marginOnly(bottom: 100),
          ],
        ),
      ),
    );

  }
}
