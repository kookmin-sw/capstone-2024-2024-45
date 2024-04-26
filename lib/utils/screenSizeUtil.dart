import 'package:flutter/cupertino.dart';

/*
상대 크기 지정을 위해 screenSize 얻어오는 클래스 지정
 */
class ScreenSizeUtil {
  static Size screenSize(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size;
  }

  static double screenWidth(BuildContext context) {
    return screenSize(context).width;
  }

  static double screenHeight(BuildContext context) {
    return screenSize(context).height;
  }
}