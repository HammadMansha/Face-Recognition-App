import 'package:ai_test_app/utils/libraries/app_libraries.dart';



class RecordController extends GetxController{


  TextEditingController name = TextEditingController(text: "Hammad");
  TextEditingController ref = TextEditingController();
  TextEditingController summary = TextEditingController();
  String image="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";

  Map useData={};


  @override
  void onInit() {
    // TODO: implement onInit

    if(Get.arguments!=null){
      name.text=Get.arguments["name"];
      ref.text=Get.arguments["ref"];
      summary.text=Get.arguments["summary"]??"";
      image=Get.arguments["image"].toString();


    }
    print("User data==========================${useData}");
    super.onInit();
  }


}