import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors/app_colors.dart';

enum ValidationType { EMAIL, TEXT }

class InputWidget extends StatelessWidget {
  TextEditingController? controller;
  var inputType;
  var onChanged;
  var onDone;
  var onTap;
  Color? bgColor;
  String? hint;
  int? maxLines;
  int? minLines;
  double? radius;
  List<TextInputFormatter>? inputFormatters;
  Widget? suffixIcon;
  Widget? prefixIcon;
  EdgeInsets? contentPadding;
  String? errorMsg;
  bool obscureText;
  var margin;
  bool? isReadOnly;
  double? height;
  String? initialVal;
  InputBorder? inputBorder;
  FocusNode? focusNode;

  InputWidget({this.controller,
    this.inputType = TextInputType.text,
    this.bgColor,
    this.hint,
    this.height,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.onDone,
    this.onTap,
    this.inputFormatters,
    this.suffixIcon,
    this.radius,
    this.contentPadding,
    this.errorMsg,
    this.prefixIcon,
    this.margin,
    this.isReadOnly,
    this.obscureText = false,
    this.initialVal,
    this.inputBorder,
    this.focusNode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50.h,
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        textAlign: TextAlign.start,
        style: const TextStyle(color: Colors.black),
        textInputAction: TextInputAction.done,
        focusNode: focusNode,
        inputFormatters: inputFormatters ??
            [FilteringTextInputFormatter.singleLineFormatter],
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
        onChanged: onChanged,
        obscureText: obscureText,
        onTap: onTap,
        readOnly: isReadOnly ?? false,
        cursorColor: AppColors.appMainColor,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          border: inputBorder ?? InputBorder.none,
          hintText: hint ?? "",
          contentPadding: contentPadding,
          hintStyle: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: AppColors.color_696F79),
          counterText: "",
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
