import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/colors/app_colors.dart';

class AppTxtStyles{
  static final mainTxtStyle = TextStyle(
      fontSize: 18.sp,
      color: Colors.black,
      fontWeight: FontWeight.w600,
  );
  static final subHeaderTxtStyle = TextStyle(
      fontSize: 12.sp,
      color: AppColors.color_696F79,
      fontWeight: FontWeight.w500,
  );

  static final inputTxtStyle = TextStyle(
      fontSize: 16.sp,
      color: AppColors.color_333333,
      fontWeight: FontWeight.w500,
  );
  static final btnTxtStyle = TextStyle(
      fontSize: 14.sp,
      color: Colors.white,
      fontWeight: FontWeight.w500,
  );
  static final stepTxtStyle = TextStyle(
      fontSize: 12.sp,
      color: AppColors.appMainColor,
      fontWeight: FontWeight.w600,
  );

  static final size11Weight500ColorBlackTxtStyle = TextStyle(
      fontSize: 11.sp,
      color: Colors.black,
      fontWeight: FontWeight.w500,
  );
  static final size10Weight400TxtStyle = TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
  );
}