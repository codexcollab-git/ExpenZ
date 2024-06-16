
import 'package:balance_checker/utils/config/colors/AppColors.dart';
import 'package:balance_checker/Presentation/views/common/SpaceWidget.dart';
import 'package:balance_checker/Presentation/views/common/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TagWidgetEnum { SIP, UPI, NEFT, OTHER, CARD, ACCOUNT, WALLET  }

class TagWidget extends StatelessWidget {
  final TagWidgetEnum type;
  final String txt;
  final double radius;

  TagWidget({required this.type, required this.txt, this.radius = 15});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FittedBox(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: BorderRadius.circular(radius)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 7, right: 7, top: 4, bottom: 4),
            child: Row(
              children: [
                getIconByTag(type: type),
                SpaceWidget(width: 5,),
                TextWidget(str: txt, txtFontWeight: FontWeight.w600, txtColor: AppColors.secondaryTextColor, txtSize: 9,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  FaIcon getIconByTag({required TagWidgetEnum type}) {
    Color defColor = AppColors.secondaryTextColor;
    switch (type) {
      case TagWidgetEnum.CARD:
        return FaIcon(FontAwesomeIcons.creditCard, color: defColor, size: 10,);
      case TagWidgetEnum.SIP:
        return FaIcon(FontAwesomeIcons.piggyBank, color: defColor, size: 10,);
      case TagWidgetEnum.UPI:
        return FaIcon(FontAwesomeIcons.mobile, color: defColor, size: 10,);
      case TagWidgetEnum.OTHER:
        return FaIcon(FontAwesomeIcons.moneyBill, color: defColor, size: 10,);
      case TagWidgetEnum.NEFT:
        return FaIcon(FontAwesomeIcons.moneyBillTransfer, color: defColor, size: 10,);
      case TagWidgetEnum.ACCOUNT:
        return FaIcon(FontAwesomeIcons.buildingColumns, color: defColor, size: 10,);
      case TagWidgetEnum.WALLET:
        return FaIcon(FontAwesomeIcons.wallet, color: defColor, size: 10,);
    }
  }
}