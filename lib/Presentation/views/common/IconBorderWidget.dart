
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../utils/config/colors/AppColors.dart';


class IconBorderWidget extends StatelessWidget {
  final bool showBorder;
  final IconData? icon;
  final Color accentColor;
  final double iconSize;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final EdgeInsets? iconPadding;
  final EdgeInsets? iconMargin;
  final double borderRadius;

  IconBorderWidget(
      {this.showBorder = false,
      this.icon,
      required this.accentColor,
      this.padding,
      this.iconSize = 16,
      this.margin,
      this.iconMargin,
      this.iconPadding,
      this.borderRadius = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: Container(
          margin: margin ?? const EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          child: Center(
              child: Padding(
                padding: iconPadding ?? const EdgeInsets.all(0),
                child: Container(
                  margin: iconMargin ?? const EdgeInsets.all(0),
                  child: FaIcon(
                              icon,
                              color: accentColor,
                              size: iconSize,
                            ),
                ),
              )),
        ));
  }
}
