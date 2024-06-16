
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../utils/config/colors/AppColors.dart';

class TextWidget extends StatelessWidget {
  final String str;
  final Color? txtColor;
  final FontWeight? txtFontWeight;
  final double? txtSize;
  final int? maxLine;
  final TextAlign? textAlign;
  final Alignment? alignment;

  TextWidget({required this.str, this.txtColor, this.txtFontWeight, this.txtSize, this.maxLine, this.textAlign, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.topLeft,
      child: Text(str,
        style: textStyle(color: txtColor, weight: txtFontWeight, size: txtSize,),
        maxLines: maxLine,
        textAlign: textAlign ?? TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),);
  }

  TextStyle textStyle({
    Color? color = AppColors.tagChipColor,
    String font = 'RedditSans',
    FontWeight? weight = FontWeight.w700,
    double? size = 17}) {
    return TextStyle(
        color: color,
        fontFamily: font,
        fontWeight: weight,
        decoration: TextDecoration.none,
        fontSize: size);
  }
}

