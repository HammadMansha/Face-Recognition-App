import 'package:ai_test_app/controllers/record_view/record_controller.dart';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';

import '../../widgets/common_textfields/commn_textfield.dart';
import '../../widgets/common_textstyle/common_text_style.dart';

class RecordViewScreen extends StatelessWidget {
  const RecordViewScreen({super.key});

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
          "Record",
          style: CommonTextStyle.style7font16weight700white,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: bodyData(context),
    );
  }

  bodyData(BuildContext context) {
    RecordController recordController = Get.put(RecordController());
    return Container(
      height: Get.height,
      width: Get.width,
      color: Colors.black,
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile_pic.png"),
            radius: 80,
          ),

          Text(
            "David Smith",
            style: CommonTextStyle.font15weight600White,
          ).marginOnly(top: 20),

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
                child: CommonTextField(readOnly: true,
                  fillcolor: Colors.white,
                  controller: recordController.name,
                  bordercolor: AppColors.colorC9C9,
                  disableBorderColor: AppColors.colorC9C9,
                  textColor: Colors.black,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          ).marginOnly(top: 50),

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
                  readOnly: true,
                  fillcolor: Colors.white,
                  controller: recordController.ref,
                  bordercolor: AppColors.colorC9C9,
                  disableBorderColor: AppColors.colorC9C9,
                  textColor: Colors.black,
                  textInputAction: TextInputAction.next,
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
                  readOnly: true,
                  fillcolor: Colors.white,
                  controller: recordController.summary,
                  bordercolor: AppColors.colorC9C9,
                  disableBorderColor: AppColors.colorC9C9,
                  maxLine: 7,
                  textColor: Colors.black,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),

          //----------------------------Section if image selected-------------------
        ],
      ).marginSymmetric(horizontal: 25),
    );
  }
}
