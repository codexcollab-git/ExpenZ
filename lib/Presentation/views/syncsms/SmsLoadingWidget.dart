import 'dart:io';
import 'dart:math';

import 'package:balance_checker/Presentation/views/common/EmptyWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/config/colors/AppColors.dart';
import '../../../utils/config/strings/AppStrings.dart';
import '../common/SpaceWidget.dart';
import '../common/TextWidget.dart';

class SmsLoadingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _loadingLottie();
  }

  _loadingLottie() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(flex: 1, child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Image.asset('assets/images/appicon.png', height: 38, width: 200,),
            ),
          )),
          Expanded(flex: 6, child: Container(
            color: AppColors.background,
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRect(
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                              height: 350,
                              width: 350,
                              child: Lottie.asset('assets/animation/loading.json', fit: BoxFit.cover))),
                    )
                  ],
                ),
              ),
            ),
          )),
          Expanded(flex: 3, child: Padding(
            padding: const EdgeInsets.only(left: 60, right: 60),
            child: Center(
              child: Column(
                children: [
                  TextWidget(str: AppStrings.calculateExpense, txtColor: AppColors.secondaryTextColor, txtFontWeight: FontWeight.w700, txtSize: 15, maxLine: 4, alignment: Alignment.center,),
                  SpaceWidget(height: 15,),
                  TextWidget(str: AppStrings.inProgressScreenSubHead, txtColor: AppColors.secondaryTextColor, txtFontWeight: FontWeight.w400, txtSize: 14, maxLine: 5, alignment: Alignment.center,),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
