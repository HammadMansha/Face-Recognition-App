
import 'package:ai_test_app/utils/libraries/app_libraries.dart';
import 'package:ai_test_app/views/dashboard/dashboard_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_routes.dart';

class LoginScreenController extends GetxController{

TextEditingController username =TextEditingController();
TextEditingController password =TextEditingController();
final formKey = GlobalKey<FormState>();
RxBool secureText=true.obs;
RxBool isAuthenticated = false.obs;



@override
  void onInit() {
  saveCredentials( "hammad@gmail.com","12345678");
    // TODO: implement onInit
    super.onInit();
  }

// email validator
  bool isEmptyField(String value){
    if(value.isEmpty){
      return true;
    }
    else{
      return false;
    }
  }




// Save user credentials
  Future<void> saveCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);
  }

// Retrieve user credentials
  Future<Map<String, String>> getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    String password = prefs.getString('password') ?? '';
    return {'username': username, 'password': password};
  }


  //authentication function
  Future<void> authenticate(String enteredUsername, String enteredPassword) async {
    Map<String, String> storedCredentials = await getCredentials();
    String storedUsername = storedCredentials['username']!;
    String storedPassword = storedCredentials['password']!;

    if (enteredUsername == storedUsername && enteredPassword == storedPassword) {
      isAuthenticated.value = true;
      Get.offAndToNamed(Routes.dashboardScreen);
      Get.snackbar('Authentication Success', 'Login successfully',
          snackPosition: SnackPosition.TOP);
    } else {
      isAuthenticated.value = false;
      Get.snackbar('Authentication Failed', 'Invalid username or password',
          snackPosition: SnackPosition.TOP);
    }
  }





}