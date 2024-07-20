import 'package:flutter/material.dart';
import 'package:infinite_scroll_search/main.dart';
import 'package:infinite_scroll_search/widget/reponsive/extension.dart';

class StyleThemeData {
  static TextStyle size14Weight400({Color? color, double height = 1.5}) => TextStyle(
        fontSize: 14.fontSize,
        fontWeight: FontWeight.w400,
        color: color ?? appTheme.blackColor,
        height: height.h,
      );

  static TextStyle size16Weight400({BuildContext? context, Color? color, double height = 1.5}) => TextStyle(
        fontSize: 16.fontSize,
        fontWeight: FontWeight.w400,
        color: color ?? appTheme.blackColor,
        height: height.h,
        letterSpacing: 0.2,
      );

  static TextStyle size16Weight600({Color? color, double height = 1.5}) => TextStyle(
        fontSize: 16.fontSize,
        fontWeight: FontWeight.w600,
        color: color ?? appTheme.blackColor,
        height: height.h,
      );

  static TextStyle size24Weight700({Color? color, double height = 1.5}) => TextStyle(
        fontSize: 24.fontSize,
        fontWeight: FontWeight.w700,
        color: color ?? appTheme.blackColor,
        height: height.h,
      );
}
