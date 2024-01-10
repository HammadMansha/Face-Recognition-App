
import '../../../widgets/form_validator/email_validator.dart';

abstract class ValidateUserEmail {
  //---------------Only email validator-------------------
  bool isValidEmail(String email) {
    return EmailValidator.validate(email);
  }
//---------------Password validator if no need to check upper and lower case characters---------------
  String? isPasswordEmpty(String password, [int minLength = 8, int maxLength = 32]) {
    if (password.isEmpty) {
      // return false;
      return 'This field is required';
    }
    var hasMinLength =
        password.length >= minLength && password.length <= maxLength;

    if (password.length < 8) {
      return 'Password must be greater than 8 characters';
    }

    if (password.length > 32) {
      return 'Password must smaller than 32 characters';
    }
    return null;
  }

  //-----------------------------Validator fun use in textField--------------------
  String? validateEmptyPassword(String value) {
    return isPasswordEmpty(value,);
  }

  //------------------Validate only empty fields----------------------
  String? isEmptyField(String value){
    if(value.isEmpty){
      return "This field is required";
    }
    else{
      return null;
    }
  }




  //---------------Password validator if  need to check upper and lower case and special characters---------------


  String? isPasswordComplete(
    String password, [
    int minLength = 8,
  ]) {
    if (password.isEmpty) {
      // return false;
      return 'This is a required field';
    }

    var hasUppercase = password.contains(RegExp(r'[A-Z]'));
    var hasDigits = password.contains(RegExp(r'[0-9]'));
    var hasLowercase = password.contains(RegExp(r'[a-z]'));
    var hasSpecialCharacters =
        password.contains(RegExp(r'[!"#$%&(' ')*+,-./:;<=>?@[\\]^_`{|}~]'));
    var hasMinLength = password.length >= minLength;
    if (!hasUppercase) {
      return 'Password must include one upper case letter';
    }
    if (!hasLowercase) {
      return 'Password must include one lower case letter';
    }
    if (!hasDigits) {
      return 'Password must include one digit';
    }
    if (!hasSpecialCharacters) {
      return 'Password must include one special character';
    }
    if (!hasMinLength) {
      return 'Password length must be greater than 8 characters';
    }
    if (password.length > 24) {
      return 'Password length must be smaller than 24 characters';
    }

    return null;
  }

  //---------------------Password validator for textField use---------------------
  String? validatePasswordOnPressed(String value) {
    return isPasswordComplete(
      value,
    );
  }
}
