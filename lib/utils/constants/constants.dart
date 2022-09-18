class Constants {
  //UI
  static const double padding = 16;

  static const String googleMapKeyIos =
      'AIzaSyBRjT8ScgjVDqeiHIDjn1x-neyhWE0X9Fk';
  static const String googleMapKeyAndroid =
      'AIzaSyBRjT8ScgjVDqeiHIDjn1x-neyhWE0X9Fk';

  static final RegExp regexPhone =
      RegExp(r'^(5)(5|0|3|6|4|9|1|8|7){1}([0-9]{7})$');
  static final RegExp regexName = RegExp("[a-zA-Zء-ي ]");
}
