import 'dart:ui';

import 'package:balance_checker/utils/config/colors/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class DividerWidget extends StatelessWidget {
  final double dividerHeight;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color dividerColor;

  DividerWidget(
      {this.dividerHeight = 1, this.margin, this.padding, this.dividerColor = AppColors.dividerColor,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Container(
        margin: margin ?? const EdgeInsets.all(0),
        width: double.infinity,
        height: dividerHeight,
        color: dividerColor,
      ),
    );
  }
}
