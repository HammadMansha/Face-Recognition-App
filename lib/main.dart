import 'package:ai_test_app/routes/app_pagess.dart';
import 'package:ai_test_app/services/auth_service/auth_services.dart';
import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:get_storage/get_storage.dart';




Future<void> main() async {
// Ensure that plugin services are initialized so that `availableCameras()`
// can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

// Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  runApp(const MyApp());
}

Future<void> initServices() async {
  await GetStorage.init();
  // bio
  //AuthService auth = AuthService();
  //await Get.putAsync(() => auth.init());
  // await Get.putAsync(() => bio.init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      //title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(background: Colors.black,onBackground: Colors.black),
        primarySwatch: Colors.blue,
        backgroundColor: Colors.black,
        ),
      defaultTransition: Get.defaultTransition,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      //home: MyHomePage(),
    );

  }
}
