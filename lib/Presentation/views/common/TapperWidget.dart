import 'package:balance_checker/utils/config/colors/AppColors.dart';
import 'package:flutter/material.dart';


class TapperWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback callback;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? rippleColor;
  final double? circleRadius;

  const TapperWidget({
    required this.child,
    required this.callback,
    this.borderRadius,
    this.backgroundColor,
    this.rippleColor,
    this.circleRadius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(circleRadius ?? 0)),
      child: Material(
        color: backgroundColor ?? Colors.transparent,
        child: InkWell(
          splashColor: rippleColor ?? AppColors.dividerColor,
          onTap: callback,
          child: child,
        ),
      ),
    );
  }
}