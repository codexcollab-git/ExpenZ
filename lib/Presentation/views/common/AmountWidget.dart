import 'dart:ui';

import 'package:balance_checker/Presentation/views/common/TextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/config/colors/AppColors.dart';

class AmountWidget extends StatelessWidget {
  final bool isCredit;
  final String amount;
  final double txtSize;
  final FontWeight txtFontWeight;

  AmountWidget({required this.isCredit, required this.amount, this.txtSize = 16, this.txtFontWeight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    return TextWidget(str: isCredit ? '+ $amount' : '- $amount',
    txtSize: txtSize, txtFontWeight: txtFontWeight,
        txtColor: isCredit ? AppColors.creditTextColor : AppColors.debitTextColor,);
  }
}

