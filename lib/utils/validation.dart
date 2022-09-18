import 'constants/constants.dart';

class Validation {
  static bool isCorrectNumber(String phoneNumber) {
    return Constants.regexPhone.hasMatch(phoneNumber);
  }
}
