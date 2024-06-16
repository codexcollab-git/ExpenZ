import 'dart:ui';

import 'package:balance_checker/utils/config/colors/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class IconWidget extends StatelessWidget {
  final IconData? icon;
  final Color accentColor;
  final double iconSize;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? bgColor;
  final double? borderRadius;

  IconWidget(
      {this.icon,
      required this.accentColor,
      this.padding,
      this.iconSize = 16,
      this.margin,
      this.bgColor,
      this.borderRadius
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: Center(child: FaIcon(icon, color: accentColor, size: iconSize, shadows: [
          Shadow(color: Colors.white, blurRadius: 10),
        ],
        )),
      ),
    );
  }
}
