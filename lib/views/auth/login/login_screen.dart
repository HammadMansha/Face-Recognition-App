import 'package:ai_test_app/controllers/auth/login/login_controller.dart';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:ai_test_app/widgets/common_buttons/common_button.dart';
import 'package:ai_test_app/widgets/common_textfields/commn_textfield.dart';
import 'package:ai_test_app/widgets/common_textstyle/common_text_style.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../classes/abstract_classes/validate_email/validate_email.dart';
import '../../../routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyData(context),
    );
  }

  bodyData(BuildContext context) {
    LoginScreenController loginScreenController =
        Get.put(LoginScreenController());
    return SafeArea(
      child: Container(
        color: Colors.black,
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Form(
            key: loginScreenController.formKey,
            child: Column(
              children: [
                 SizedBox(
                  height: Get.height/7,
                ),
               Container(
                 height: 200,
                 width: 200,
                 decoration: const BoxDecoration(
                   image: DecorationImage(
                     image: AssetImage("assets/images/face.png"),
                   )
                 ),
               ),
                Text(
                  "Welcome!",
                  style: CommonTextStyle.font27weight500F8FAOutfit,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.person_2_outlined,
                      size: 22,
                    ),
                    Text(
                      " Login Account",
                      style: CommonTextStyle.font18weight7White,
                    ),
                  ],
                ).marginOnly(top: 60, bottom: 20),
                CommonTextField(
                  bordercolor: AppColors.colorC9C9,
                  prefixIcon: Icons.person_2_outlined,
                  disableBorderColor: AppColors.colorC9C9,

                  hintTextColor: AppColors.hintTextColor,

                  controller: loginScreenController.username,
                  //hintText: 'Email',
                  labelText: "Enter Email ID",

                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'This filed is required';
                    } else if (loginScreenController.isEmptyField(value.toString())) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                  ],
                  onChanged: (value) {
                    value = value.replaceAll(' ', '');
                  },
                ),
                Obx(
                  () => CommonTextField(
                    bordercolor: AppColors.colorC9C9,

                    disableBorderColor: AppColors.colorC9C9,
                    prefixIcon: Icons.password_outlined,
                    controller: loginScreenController.password,
                    hintTextColor: AppColors.hintTextColor,
                    //hintText: 'Email',
                    labelText: "Enter Password",
                    textInputAction: TextInputAction.next,

                    isTextHidden: loginScreenController.secureText.value,
                    togglePassword: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                    ],
                    toggleIcon: loginScreenController.secureText.value == true
                        ? Icons.visibility_off_outlined
                        : Icons.remove_red_eye_outlined,
                    toggleFunction: () {
                      loginScreenController.secureText.value =
                          !loginScreenController.secureText.value;
                      loginScreenController.update();
                    },

                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'This filed is required';
                      }
                      return null;
                    },

                    onChanged: (value) {
                      value = value.replaceAll(' ', '');
                    },
                  ).marginSymmetric(vertical: 20),
                ),
                CommonButton(
                        height: 48,
                        width: Get.width,
                        text: "Login",
                        textStyle: CommonTextStyle.font16weight700F8FAPublic,
                        onPressed: ()async {
                          if (loginScreenController.formKey.currentState!.validate()) {
                           await loginScreenController.authenticate(loginScreenController.username.text, loginScreenController.password.text);
                          }
                        },
                        fillColor: AppColors.colorF2A9).marginOnly(top: 40),
              ],
            ).marginSymmetric(horizontal: 30),
          ),
        ),
      ),
    );
  }
}
