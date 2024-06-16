import 'dart:ui';

import 'package:balance_checker/Presentation/views/common/SpaceWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/config/colors/AppColors.dart';
import 'TextWidget.dart';

class IndicatorWidget extends StatelessWidget {
  final Color accentColor;
  final String heading;

  IndicatorWidget({
    required this.accentColor,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Row(
          children: [
            Container(
              height: 12,
            width: 12,
                decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)))),
        SpaceWidget(width: 5,),
        TextWidget(str: heading, txtColor: AppColors.primaryTextColor, textAlign: TextAlign.start,
          txtFontWeight: FontWeight.w700, txtSize: 11, maxLine: 2, alignment: Alignment.topLeft,),
          ],
        ),
      ),
    );
  }
}
