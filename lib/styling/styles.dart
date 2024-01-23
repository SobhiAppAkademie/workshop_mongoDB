import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  Styles._();

  static TextStyle thin(double fontSize,
      {Color color = Colors.black, List<Shadow> shadows = const []}) {
    return TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontFamily: "TT",
        fontWeight: FontWeight.w200,
        shadows: shadows);
  }

  static TextStyle light(double fontSize,
      {Color color = Colors.black, List<Shadow> shadows = const []}) {
    return TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontFamily: "TT",
        fontWeight: FontWeight.w300,
        shadows: shadows);
  }

  static TextStyle regular(double fontSize,
      {Color color = Colors.black, List<Shadow> shadows = const []}) {
    return TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontFamily: "TT",
        fontWeight: FontWeight.w400,
        shadows: shadows);
  }

  static TextStyle medium(double fontSize,
      {Color color = Colors.black, List<Shadow> shadows = const []}) {
    return TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontFamily: "TT",
        fontWeight: FontWeight.w500,
        shadows: shadows);
  }

  static TextStyle semiBold(double fontSize,
      {Color color = Colors.black, List<Shadow> shadows = const []}) {
    return TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontFamily: "TT",
        fontWeight: FontWeight.w600,
        shadows: shadows);
  }

  static TextStyle bold(double fontSize,
      {Color color = Colors.black, List<Shadow> shadows = const []}) {
    return TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontFamily: "TT",
        fontWeight: FontWeight.w700,
        shadows: shadows);
  }

  static TextStyle extraBold(double fontSize,
      {Color color = Colors.black, List<Shadow> shadows = const []}) {
    return TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontFamily: "TT",
        fontWeight: FontWeight.w800,
        shadows: shadows);
  }

  static TextStyle black(double fontSize,
      {Color color = Colors.black, List<Shadow> shadows = const []}) {
    return TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontFamily: "TT",
        fontWeight: FontWeight.w900,
        shadows: shadows);
  }

  static TextStyle header(double fontSize,
      {Color color = Colors.black, List<Shadow> shadows = const []}) {
    return TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontFamily: "Galfego",
        fontWeight: FontWeight.w300,
        shadows: shadows);
  }
}
