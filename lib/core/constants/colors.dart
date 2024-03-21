import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff51B1A6);
  static const Color grey = Color(0xff6C757D);
  static const Color light = Color(0xffE4E7EE);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color red = Color(0xffD34459);
  static const Color stroke = Color(0xffE5E8EE);
  static const Color bgLogin = Color(0xffEDEDED);
  static const Color border = Color(0xffEFEEF1);
}

/// text style
TextStyle primaryTextStyle = const TextStyle(color: AppColors.primary);
TextStyle blackTextStyle = const TextStyle(color: AppColors.black);
TextStyle whiteTextStyle = const TextStyle(color: AppColors.white);
TextStyle greyTextStyle = const TextStyle(color: AppColors.grey);
TextStyle redTextStyle = const TextStyle(color: AppColors.red);

/// text weight
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;