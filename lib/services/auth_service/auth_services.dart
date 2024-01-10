// import '../../classes/abstract_classes/localstorage_abstract.dart';
// import '../../utils/libraries/app_libraries.dart';
//
//
// class AuthService extends GetxService with InitializeLocalStorage{
//   bool loggedInUser = false;
//
//   Future<AuthService> init() async {
//     await checkLogin();
//     return this;
//   }
//
//   Future<bool> checkLogin() async {
//     if (kDebugMode) {
//       print(storage.read("isAppOpen"));
//     }
//     if (storage.hasData("isAppOpen")) {
//       loggedInUser = true;
//     } else {
//       loggedInUser = false;
//     }
//     return loggedInUser;
//   }
// }