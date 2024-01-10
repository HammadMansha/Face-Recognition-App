
import 'package:ai_test_app/controllers/auth/login/login_controller.dart';
import 'package:ai_test_app/routes/app_routes.dart';
import 'package:ai_test_app/views/dashboard/dashboard_screen.dart';
import 'package:ai_test_app/views/gallery_upload/upload_gallery.dart';
import 'package:ai_test_app/views/match_database/match_database.dart';
import 'package:ai_test_app/views/open_camera/open_camera.dart';
import 'package:ai_test_app/views/record_screen/record_screen.dart';
import 'package:ai_test_app/views/splash/splash_screen.dart';

import '../utils/libraries/app_libraries.dart';
import '../views/auth/login/login_screen.dart';

class AppPages {
  static var initial = Routes.matchDatabaseScreen;
  static final routes = [

    //----------------------Splash screen route------------------

    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),

    //----------------------Dashboard screen route------------------

    GetPage(
      name: Routes.dashboardScreen,
      page: () => const DashboardScreen(),
    ),


    //----------------------Login screen route------------------

    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
    ),

    //----------------------Upload Gallery screen route------------------

    GetPage(
      name: Routes.uploadGallery,
      page: () => const UploadFromGallery(),
    ),


    //----------------------Record screen route------------------

    GetPage(
      name: Routes.recordScreen,
      page: () => const RecordViewScreen(),
    ),


    //----------------------open camera screen route------------------

    GetPage(
      name: Routes.openCameraScreen,
      page: () => const OpenCameraScreen(),
    ),


    //----------------------Match databse screen route------------------

    GetPage(
      name: Routes.matchDatabaseScreen,
      page: () => const MatchDatabaseScreen(),
    ),

  ];
}
