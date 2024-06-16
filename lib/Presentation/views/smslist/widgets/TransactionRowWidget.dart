import 'dart:ui';

import 'package:balance_checker/Presentation/views/common/EmptyWidget.dart';
import 'package:balance_checker/Presentation/views/common/PopUpMenuTextWidget.dart';
import 'package:balance_checker/Presentation/views/smslist/model/options.dart';
import 'package:balance_checker/floor/entities/SmsEntity.dart';
import 'package:balance_checker/Presentation/views/common/AmountWidget.dart';
import 'package:balance_checker/Presentation/views/common/DividerWidget.dart';
import 'package:balance_checker/Presentation/views/common/IconWidget.dart';
import 'package:balance_checker/Presentation/views/common/SpaceWidget.dart';
import 'package:balance_checker/Presentation/views/common/TapperWidget.dart';
import 'package:balance_checker/Presentation/views/common/TextWidget.dart';
import 'package:balance_checker/utils/common/CommonUtils.dart';
import 'package:balance_checker/utils/config/strings/AppStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/common/DateTimeUtils.dart';
import '../../../../utils/config/colors/AppColors.dart';
import '../../common/CustomDialog.dart';
import '../../common/IconBorderWidget.dart';
import '../../common/TagWidget.dart';
import 'SmsContainerWidget.dart';


class TransactionRowWidget extends StatefulWidget {

  final SmsEntity sms;
  final SmsEntity? prevSms;
  final bool expended;
  final void Function(SmsEntity sms) onSmsPressed;

  TransactionRowWidget({Key? key, required this.sms, required this.prevSms,
    this.expended = false, required this.onSmsPressed}) : super(key: key);

  @override
  _TransactionRowWidget createState() => _TransactionRowWidget();
}


class _TransactionRowWidget extends State<TransactionRowWidget> {

  late SmsEntity sms;
  late SmsEntity? prevSms;
  late bool expended;
  late void Function(SmsEntity sms) onSmsPressed;

  @override
  void initState() {
    super.initState();
    sms = widget.sms;
    prevSms = widget.prevSms;
    expended = widget.expended;
    onSmsPressed = widget.onSmsPressed;
  }

  @override
  Widget build(BuildContext context) {
    if (sms.hide == 1) {
      return EmptyWidget();
    } else {
      return _buildRow(context);
    }
  }

  Widget _buildRow(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Column(
        children: [

          _buildDate(),

          TapperWidget(
            rippleColor: AppColors.borderColor,
            circleRadius: 0,
            callback: () => {
              setState(() {
              expended = !expended;
              })
            },
            child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
                child: Column (
                  children: [

                    SizedBox(
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(top:0, bottom: 7 ),
                            child: Row (
                              children: [

                               _buildIcon(),

                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5, right: 5),
                                      child: Column(
                                        children: [
                                          TextWidget(str: sms.bankName ?? '', txtColor: AppColors.primaryTextColor, textAlign: TextAlign.start,
                                            txtFontWeight: FontWeight.w600, txtSize: 13, maxLine: 2, alignment: Alignment.topLeft,),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Wrap(
                                              children: [
                                                _buildTransactionMode(),
                                                _buildAccountNumber(),
                                                _buildAccountName()
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildAmount(),
                                      SpaceWidget(height: 8,),
                                      _popUpMenu(context),
                                      //IconWidget(icon: FontAwesomeIcons.ellipsis, accentColor: AppColors.iconLightColor, iconSize: 20,),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SpaceWidget(height: 5,),

                          expended ? SmsContainerWidget(sender: sms.smsSender ?? '', body: sms.smsBody ?? '') : EmptyWidget()
                        ],
                      ),
                    ),

                  ],
                )
            ),
          ),

          DividerWidget(dividerColor: AppColors.borderColor, margin: const EdgeInsets.only(left: 40, right: 25),)

        ],
      ),
    );
  }

  _popUpMenu(BuildContext context) {
    List<Options> options = [
      Options(id: 1, title: AppStrings.remove, icon: FaIcon(FontAwesomeIcons.trash, color: AppColors.iconLightColor, size: 12,),),
    ];
    MenuController? _controller = null;
    return MenuAnchor(
      style: MenuStyle(
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
      ),
      builder: (BuildContext context, MenuController controller, Widget? child) {
        _controller = controller;
        return TapperWidget(
          callback: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: IconBorderWidget(
            accentColor:
            AppColors.iconLightColor,
            icon: FontAwesomeIcons.ellipsis,
            iconSize: 20,
            iconMargin: EdgeInsets.only(left: 5, right: 5),
          ),
        );
      },
      menuChildren: [
        PopupMenuTextWidget(
          onOptionSelected: (option) {
            switch(option.id) {
              case 1 : {
                _showRemoveTransactionDialog(context);
                _controller?.close();
                break;
              }
              default : {
                _controller?.close();
                break;
              }
            }
          },
          optionList: options,
          txtFontWeight: FontWeight.w600,
          txtSize: 13,
          txtColor: AppColors.primaryTextColor,
          padding: EdgeInsets.only(top: 9, bottom: 9, left: 17, right: 17),
        )
        ],
    );
  }

  _showRemoveTransactionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => CustomDialog(
        title: AppStrings.removeTransaction,
        message: AppStrings.removeTransactionSubHead,
        actions: [
          TextButton(
            child: Text(AppStrings.cancel, style: TextStyle(color: AppColors.smsTextSecondaryColor),),
            onPressed: () => {
              Navigator.of(ctx).pop()
            },
          ),
          TextButton(
              child: Text(AppStrings.remove, style: TextStyle(color: AppColors.indicatorColor,),),
              onPressed: () async => {
                Navigator.of(ctx).pop(),
                sms.hide = 1,
                _onTap(),
              }
          ),
        ],
      ),
    );
  }

  _buildDate() {
    if (prevSms == null || prevSms?.smsDateTime != sms.smsDateTime) {
      return _showDate();
    } else {
      return EmptyWidget();
    }
  }

  _showDate() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, bottom: 10, top: 15),
      child: TextWidget(str: onlyDateStringFromTimestamp(timestamp: sms.smsDateTime ?? 0), txtColor: AppColors.secondaryTextColor, txtFontWeight: FontWeight.w400, txtSize: 12,),
    );
  }

  _buildIcon() {
    if (sms.transactionTypeEnum != 'null') {
      if (sms.transactionTypeEnum == 'debit') {
        return IconWidget(
          accentColor: AppColors.debitTextColor,
          icon: FontAwesomeIcons.arrowTrendDown,
          iconSize: 25,
          bgColor: AppColors.debitBGColor,
          borderRadius: 12,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 20, right: 15),);
      } else {
        return IconWidget(accentColor: AppColors.creditTextColor,
          icon: FontAwesomeIcons.arrowTrendUp,
          iconSize: 25,
          bgColor: AppColors.creditBGColor,
          borderRadius: 12,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 20, right: 15),);
      }
    }
  }

  _buildTransactionMode() {
    if (sms.transactionModeEnum != 'null') {
      switch(sms.transactionModeEnum) {
        case 'upi' : {
          return TagWidget(type: TagWidgetEnum.UPI, txt: AppStrings.upi);
        }
        case 'sip' : {
          return TagWidget(type: TagWidgetEnum.SIP, txt: AppStrings.sip);
        }
        case 'neft' : {
          return TagWidget(type: TagWidgetEnum.NEFT, txt: AppStrings.neft);
        }
        case 'other' : {
          return TagWidget(type: TagWidgetEnum.OTHER, txt: AppStrings.other);
        }
      }
    }
  }

  _buildAccountNumber() {
    if (sms.accountNo != null) {
      switch (sms.accountTypeEnum) {
        case 'ACCOUNT' :
          {
            return TagWidget(type: TagWidgetEnum.ACCOUNT,
                txt: "A/C ${sms.accountNo ?? '-'}");
          }
        case 'CARD' :
          {
            return TagWidget(
                type: TagWidgetEnum.CARD, txt: "Card XX ${sms.accountNo ?? '-'}");
          }
        case 'WALLET' :
          {
            return TagWidget(
                type: TagWidgetEnum.WALLET, txt: "Wallet ${sms.accountNo ?? '-'}");
          }
        default :
          {
            return EmptyWidget();
          }
      }
    } else {
      return EmptyWidget();
    }
  }

  _buildAccountName() {
    if (sms.accountName != null) {
      return TagWidget(type: TagWidgetEnum.ACCOUNT, txt: '${sms.accountName}');
    } else {
      return EmptyWidget();
    }
  }

  _buildAmount() {
    if (sms.transactionTypeEnum != 'null') {
      if (sms.transactionTypeEnum == 'debit') {
        return AmountWidget(isCredit: false, txtSize: 14, txtFontWeight: FontWeight.w600, amount: wrapAroundRupee('${sms.transactionAmount}'));
      } else {
        return AmountWidget(isCredit: true, txtSize: 14, txtFontWeight: FontWeight.w600, amount: wrapAroundRupee('${sms.transactionAmount}'));
      }
    }
  }

  void _onTap() {
    onSmsPressed.call(sms);
  }
}