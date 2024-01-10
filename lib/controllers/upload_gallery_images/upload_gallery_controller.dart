import 'dart:core';
import 'dart:io';

import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;


class UploadGalleryController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController ref = TextEditingController();
  TextEditingController summary = TextEditingController();

  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();

  List<CameraDescription>? cameras;
  String imagePath = "";
  RxBool isLoading=false.obs;


  RxList<File> selectedImages = RxList<File>();

//------------------------function for select images---------------------
  Future<void> getImages() async {
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (pickedFiles.isNotEmpty) {
      for (var i = 0; i < pickedFiles.length; i++) {
        selectedImages.add(File(pickedFiles[i].path));
      }
    } else {
      Get.snackbar("Warning", "Nothing is selected");
    }

    update();
  }

  //-------------------------Save image to gallery------------------

  Future<void> saveImagesToGallery() async {
    isLoading.value=true;
    Directory? galleryDirectory = await getExternalStorageDirectory();
    String nameValue = "${name.text.trim()}-${ref.text.trim()}-${summary.text.trim()}"; // Assuming 'name' is the TextEditingController for the user's name
    String peopleFolderPath = path.join(galleryDirectory!.path,'people', nameValue);
    Directory peopleDirectory = Directory(peopleFolderPath);

    if (!peopleDirectory.existsSync()) {
      peopleDirectory.createSync();
    }

    for (File image in selectedImages) {
      String imageName = path.basename(image.path);
      String newPath = path.join(peopleFolderPath, imageName);
      image.copySync(newPath);
      if (kDebugMode) {
        print("image path---------$newPath");
      }
    }
    name.clear();
    ref.clear();
    summary.clear();
    selectedImages.clear();
    isLoading.value=false;

    Get.snackbar('Success', 'Images saved to "$nameValue/People" folder in the gallery.');
  }








}
