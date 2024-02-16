import 'dart:io';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:ai_test_app/widgets/common_textstyle/common_text_style.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';


class DashboardController extends GetxController{

  final picker = ImagePicker();

  List<CameraDescription>? cameras;
  String imagePath = "";

  RxList<File> selectedImages = RxList<File>();

  TextEditingController enterKey=TextEditingController();

  int noOfDays=90;


  RxList<String> keys = <String>['122cfb18-dba1-4656-96fb-0cd168f2871a', 'f6744597-611b-460d-b221-7ebbd99a8eb9', '2005b09e-ae82-49d9-b0c3-fec9aa822393', '393c2572-2504-4ec3-b1f2-a3abb470e619', '60ac249a-67ce-4bfb-8f2d-4b4f1a5066e7', '0a7a36e1-b520-4dbd-9d18-3f8e6825557a', '6574cad9-e605-4e61-9144-55c8559e3a66', '716b7b57-0a95-4082-be2a-0b0612871724', 'ca94b1b7-cf61-4ae5-a66c-1e624f65b02b', '0b55f4d9-0833-4573-bb50-8e5a1ecc97cc'].obs;
  @override
  void onInit()async {
    super.onInit();






    _initializeKeysOnce();
    _loadKeys();
   await _checkThreeMonths();
  }

//Initialize keys
  Future<void> _initializeKeysOnce() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool keysInitialized = prefs.getBool('keysInitialized') ?? false;

    if (!keysInitialized) {
      print("i am in initialize");
      // Initialize the keys only if they haven't been initialized before

      prefs.setBool("isShow", true);
      prefs.setBool('keysInitialized', true);
      prefs.setStringList('keys', keys.toList());
      update();

    }
  }
//load keys
  Future<void> _loadKeys() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? loadedKeys = prefs.getStringList('keys');

    if (loadedKeys != null && loadedKeys.isNotEmpty) {
      keys = loadedKeys.obs;
      print("Keys loaded from shared preferences: ${keys.toList()}");
    } else {
      // Use default keys if none are found
      keys = <String>['122cfb18-dba1-4656-96fb-0cd168f2871a', 'f6744597-611b-460d-b221-7ebbd99a8eb9', '2005b09e-ae82-49d9-b0c3-fec9aa822393', '393c2572-2504-4ec3-b1f2-a3abb470e619', '60ac249a-67ce-4bfb-8f2d-4b4f1a5066e7', '0a7a36e1-b520-4dbd-9d18-3f8e6825557a', '6574cad9-e605-4e61-9144-55c8559e3a66', '716b7b57-0a95-4082-be2a-0b0612871724', 'ca94b1b7-cf61-4ae5-a66c-1e624f65b02b', '0b55f4d9-0833-4573-bb50-8e5a1ecc97cc'].obs;
      print("No keys found in shared preferences, using default keys.");
    }
  }
  //Check three month
  Future<void> _checkThreeMonths() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final DateTime? lastCheck = DateTime.tryParse(prefs.getString('lastCheck') ?? DateTime.now().toIso8601String());    //final DateTime lastCheck = DateTime.now().subtract(const Duration(days: 90));
    //final DateTime? lastCheck = DateTime.now().subtract(Duration(days: 90));    //final DateTime lastCheck = DateTime.now().subtract(const Duration(days: 90));

    print("value of lastCheck==============$lastCheck");
    if (lastCheck != null) {
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(lastCheck);
      print("===================================${prefs.getBool('isShow')}");

      if (difference.inDays >= noOfDays &&    prefs.getBool('isShow')==true)
     {
        print("No of day===================$noOfDays");

        // It has been more than 90 days, show a dialog
        showKeyInputDialog();
      }
    }

    // Update the last check date
  }


  //Dialog Box

  Future<void> showKeyInputDialog() async {
    return Get.defaultDialog(
      onWillPop: () => Future.value(false),
      barrierDismissible: false,
      title: "Please enter key for further use",
      titleStyle: CommonTextStyle.font16weight300White,
      content: TextField(
        controller: enterKey,
        decoration: const InputDecoration(labelText: "Key"),
      ),
      actions: [
        ElevatedButton(
          onPressed: ()async {
            checkAndRemoveKey(enterKey.text);
          },
          child: const Text("Submit"),
        ),

        ElevatedButton(
          onPressed: () {
            exit(0);
          },
          child: const Text("Close App"),
        ),
      ],
    );
  }

  //Remove Key
  void checkAndRemoveKey(String enteredKey)async {
    print("available keys are======================$keys");
    if(enterKey.text=="2005b09e-ae82-49d9-b0c3-fec9aa822393" && keys.contains(enteredKey)){

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isShow", false);

      update();
      Get.back();
    }

    else if (keys.contains(enteredKey)) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      keys.remove(enteredKey);
      _saveKeys();
      prefs.setBool("isShow", true);
      update();
      prefs.setString('lastCheck', DateTime.now().toIso8601String());
      Get.back();


// Close the pop-up
    } else {
      Get.snackbar("Error", "Invalid key");
    }
  }
//Save keys
  Future<void> _saveKeys() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('keys', keys.toList());
  }




  //-----------------Get images from gallery------------------
  Future<void> getImages() async {
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      for (var i = 0; i < pickedFiles.length; i++) {
        selectedImages.add(File(pickedFiles[i].path));
      }
    } else {
      Get.snackbar("Warning", "Nothing is selected");
    }

    update();
  }


  //----------------Capture image from camera-----------------





}