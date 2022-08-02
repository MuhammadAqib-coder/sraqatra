import 'package:flutter/cupertino.dart';

class Dimension {
  static final device =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  static double screenHeight = device.size.height;
  static double screenWidth = device.size.width;
  //height
  static double height8 = screenHeight / 80;
  static double height10 = screenHeight / 64;
  static double height15 = screenHeight / 42.67;
  static double height20 = screenHeight / 32;
  static double height22 = screenHeight / 29.09;
  static double height16 = screenHeight / 40;
  static double height18 = screenHeight / 35.55;
  static double height30 = screenHeight / 21.34;
  static double height5 = screenHeight / 128;
  static double height50 = screenHeight / 12.8;

  //width
  static double width2 = screenWidth / 180;
  static double width20 = screenWidth / 18;
  static double width5 = screenWidth / 72;
  static double width10 = screenWidth / 36;
  static double width25 = screenWidth / 14.4;
  
}
