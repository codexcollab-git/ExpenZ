
import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../utils/config/colors/AppColors.dart';
import 'TextWidget.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    this.title,
    this.message,
    this.actions = const [],
    Key? key,
  }) : super(key: key);

  final String? title;
  final String? message;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: AlertDialog(
        scrollable: false,

        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: title == null ? null : TextWidget(str: title!, txtColor: AppColors.primaryTextColor, txtFontWeight: FontWeight.w700, txtSize: 15, maxLine: 1, alignment: Alignment.center,),
        content: message == null ? null : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(str: message!, txtColor: AppColors.secondaryTextColor, txtFontWeight: FontWeight.w500, txtSize: 14, maxLine: 5, alignment: Alignment.center,),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsOverflowButtonSpacing: 8.0,
        actions: actions,
      ),
    );
  }
}