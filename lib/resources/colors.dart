import 'package:flutter/material.dart';

class AppColors {
  get colorPrimary => getColorHexFromStr('#f15b65');
  get colorPrimaryNew => getColorHexFromStr('#ffc07b');
  get buttonNew => getColorHexFromStr('#1f029a');
  get colorPrimaryNew2 => getColorHexFromStr('#fff6eb');
  get black => getColorHexFromStr('#222222');
  get colorPrimary2 => getColorHexFromStr('#fcb52e');
  get internshipDescription => getColorHexFromStr('#57595b');
  get searchHint => getColorHexFromStr('#A7A9AC');
  get emailNPhoneLogin => getColorHexFromStr("#e6e7e8");
  get internshipDetailColor => getColorHexFromStr("#d7d7d7");

  get moreTotalJobsTextColor => const Color.fromRGBO(25, 193, 255, 1);
  get greyNew => const Color.fromRGBO(0, 0, 0, 0.6);
  get greyPowerTc =>
      const Color.fromRGBO(241, 240, 240, 0.792156862745098); //Did for opacity
  get moreTotalJobsBackGroundColor =>
      const Color.fromRGBO(25, 193, 255, .2); //Did for opacity
  get moreOnGoingTextColor =>
      const Color.fromRGBO(246, 155, 32, 1); //Did for opacity
  get moreOnGoingBackGroundColor =>
      const Color.fromRGBO(246, 155, 32, .2); //Did for opacity
  get moreCompletedTextColor =>
      const Color.fromRGBO(66, 192, 56, 1); //Did for opacity
  get moreCompletedBackGroundColor =>
      const Color.fromRGBO(66, 192, 56, .2); //Did for opacity
  get noTextColor => const Color.fromRGBO(66, 192, 56, 1); //Did for opacity
  get noBackGroundColor =>
      const Color.fromRGBO(66, 192, 56, .2); //Did for opacity
  get shimmerColor => const Color.fromRGBO(192, 197, 206, .5); //Did for opacity

  static int getColorHexFromStr(String colorStr) {
    colorStr = "FF$colorStr";
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException(
            "An error occurred when converting a color");
      }
    }
    return val;
  }

  static final AppColors _appColors = AppColors._internal();
  factory AppColors() {
    return _appColors;
  }
  AppColors._internal();
}

AppColors appColors = AppColors();
