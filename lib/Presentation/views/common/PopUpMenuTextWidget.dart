
import 'dart:ui';
import 'package:balance_checker/Presentation/views/common/EmptyWidget.dart';
import 'package:balance_checker/Presentation/views/common/SpaceWidget.dart';
import 'package:balance_checker/Presentation/views/common/TapperWidget.dart';
import 'package:balance_checker/Presentation/views/smslist/model/options.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../utils/config/colors/AppColors.dart';

class PopupMenuTextWidget extends StatelessWidget {
  final Color? txtColor;
  final FontWeight? txtFontWeight;
  final double? txtSize;
  final int? maxLine;
  final TextAlign? textAlign;
  final EdgeInsets? padding;
  final void Function(Options option) onOptionSelected;
  final List<Options> optionList;
  final EdgeInsets? margin;

  PopupMenuTextWidget({this.txtColor, this.txtFontWeight,
    this.txtSize, this.maxLine, required this.onOptionSelected,
    this.textAlign, this.padding, required this.optionList, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(left:10, right: 30),
      child: Column(
        children: [
          for (var option in optionList) _buildOption(option)
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.dividerColor,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 2.0,
          ),
        ],
      ),
    );
  }

  _buildOption(Options option) {
    return TapperWidget(
      borderRadius: BorderRadius.circular(10),
      callback: () {
        onOptionSelected(option);
      },
      child: Padding(
        padding: padding ?? EdgeInsets.all(0),
        child: Row(
          children: [
           _addIcon(option),
            Text(option.title,
              style: textStyle(color: txtColor, weight: txtFontWeight, size: txtSize,),
              maxLines: maxLine,
              textAlign: textAlign ?? TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  _addIcon(Options option) {
    if (option.icon != null) {
      return Row(
        children: [
          option.icon ?? EmptyWidget(),
          SpaceWidget(width: 7,),
        ],
      );
    } else {
      return EmptyWidget();
    }
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

