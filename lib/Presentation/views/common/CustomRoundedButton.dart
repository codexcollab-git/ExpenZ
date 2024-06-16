import 'dart:ui';

import 'package:balance_checker/Presentation/views/common/SpaceWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomRoundedButton extends StatelessWidget {
  final String btnText;
  final FaIcon? btnIcon;
  final Color? btnColor;
  final TextStyle? btnTxtStyle;
  final VoidCallback btnCallback;
  final double? height;

  CustomRoundedButton(
      {required this.btnText,
      this.btnIcon,
      this.btnColor = Colors.green,
      this.btnTxtStyle,
      required this.btnCallback,
      this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: () {
          btnCallback();
        },
        child: btnIcon != null ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btnIcon!,
                  SpaceWidget(width: 10,),
                  Text(btnText, style: btnTxtStyle,)
                ],
              ) : Text(btnText, style: btnTxtStyle,),
        style: ElevatedButton.styleFrom(
            shadowColor: btnColor,
            backgroundColor: btnColor,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      ),
    );
  }
}

TextStyle roundBtnTxtTheme(
    {Color txtColor = Colors.white,
    String txtFont = 'RedditSans',
    FontWeight txtWeight = FontWeight.w600,
    double txtSize = 16}) {
  return TextStyle(
      color: txtColor,
      fontFamily: txtFont,
      fontWeight: txtWeight,
      fontSize: txtSize);
}
