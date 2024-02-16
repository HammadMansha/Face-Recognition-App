import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:ai_test_app/widgets/common_buttons/common_button.dart';
import 'package:ai_test_app/widgets/common_textstyle/common_text_style.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
    Future.delayed(const Duration(seconds: 2), () {
     Get.toNamed(Routes.loginScreen);
    });

    return SafeArea(
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.scaleDown,
            image: AssetImage(
              "assets/images/splash_screen.png",
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
                child: LoadingAnimationWidget.inkDrop(


                color: Colors.white,
                size: 30,
                ),

                  ),
          ],
        ),
      ),
    );
  }
}
