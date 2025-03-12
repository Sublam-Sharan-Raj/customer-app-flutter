import 'package:insta_closet/constants.dart';

class Validator {
  static String? valueExists(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field';
    } else {
      return null;
    }
  }

  static String? validateOtp(dynamic value) {
    var regExp = Constants.regrexValidation['otp'];
    var emptyResult = valueExists(value);
    if (emptyResult != null) {
      return emptyResult;
    } else if (!regExp!.hasMatch(value)) {
      return 'Not a valid otp. Should be like 222222';
    } else
      return null;
  }

  static String? validateMobile(dynamic value) {
    var regExp = Constants.regrexValidation['mobile'];
    var emptyResult = valueExists(value);
    if (emptyResult != null) {
      return emptyResult;
    } else if (!regExp!.hasMatch(value)) {
      return 'Please enter 10 digit mobile without 0 or +91 like e.g 7777788888';
    } else {
      return null;
    }
  }

  static String? validateEmail(dynamic value) {
    var regExp = Constants.regrexValidation['email'];
    var emptyResult = valueExists(value);
    if (emptyResult != null) {
      return emptyResult;
    } else if (!regExp!.hasMatch(value)) {
      return 'Please enter correct email id';
    } else {
      return null;
    }
  }
}
