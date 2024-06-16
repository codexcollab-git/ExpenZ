
import 'package:balance_checker/utils/config/colors/AppColors.dart';
import 'package:balance_checker/Presentation/views/common/SpaceWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SmsContainerWidget extends StatelessWidget {
  final String sender;
  final String body;

  SmsContainerWidget({required this.sender, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 80, right: 10, bottom: 15),
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.smsBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(13))),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                  child: Text(sender, style: smsSenderTxtStyle())
              ),
              SpaceWidget(height: 5,),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(body, style: smsBodyTxtStyle())
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle smsSenderTxtStyle({
    String font = 'RedditSans',
    FontWeight weight = FontWeight.w700,
    double size = 13}) {
    return TextStyle(
        color: AppColors.smsTextPrimaryColor,
        fontFamily: font,
        fontWeight: weight,
        fontSize: size);
  }

  TextStyle smsBodyTxtStyle({
    String font = 'RedditSans',
    FontWeight weight = FontWeight.w400,
    double size = 11}) {
    return TextStyle(
        color: AppColors.smsTextSecondaryColor,
        fontFamily: font,
        fontWeight: weight,
        fontSize: size);
  }
}