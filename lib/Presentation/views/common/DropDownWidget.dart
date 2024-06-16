

import 'package:balance_checker/Presentation/views/common/TextWidget.dart';
import 'package:balance_checker/Presentation/views/smslist/model/options.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/config/colors/AppColors.dart';
import 'PopUpMenuTextWidget.dart';
import 'SpaceWidget.dart';
import 'TapperWidget.dart';


class DropDownWidget extends StatefulWidget {
  final FaIcon tabIcon;
  final Options prevOption;
  final List<Options> optionList;
  final ValueSetter<Options> btnCallback;
  final EdgeInsets? margin;

  DropDownWidget({Key? key, required this.tabIcon, required this.prevOption,
    required this.optionList, required this.btnCallback, this.margin}) : super(key: key);

  @override
  _DropDownWidget createState() => _DropDownWidget();
}

class _DropDownWidget extends State<DropDownWidget> {

  late FaIcon tabIcon;
  late Options prevOption;
  late List<Options> optionList;
  late ValueSetter<Options> btnCallback;
  late EdgeInsets? margin;

  @override
  void initState() {
    super.initState();
    tabIcon = widget.tabIcon;
    prevOption = widget.prevOption;
    optionList = widget.optionList;
    btnCallback = widget.btnCallback;
    margin = widget.margin;
  }

  @override
  Widget build(BuildContext context) {
    MenuController? _controller = null;

    return MenuAnchor(
      style: MenuStyle(
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
      ),
      builder: (BuildContext context, MenuController controller, Widget? child) {
        _controller = controller;
        return TapperWidget(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          callback: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: Container(
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row (
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    tabIcon,
                    SpaceWidget(width: 7,),
                    TextWidget(str: prevOption.title, txtColor: AppColors.primaryTextColor, txtFontWeight: FontWeight.w600, txtSize: 11, alignment: Alignment.center,),
                  ],
                ),
              )
          ),
        );
      },
      menuChildren: [
        PopupMenuTextWidget(
          onOptionSelected: (option) {
            setState(() {
              prevOption = option;
              btnCallback(option);
              _controller?.close();
            });
          },
          margin: margin ?? EdgeInsets.only(left: 10, right: 5),
          optionList: optionList,
          txtFontWeight: FontWeight.w500,
          txtSize: 11,
          txtColor: AppColors.primaryTextColor,
          padding: EdgeInsets.only(top: 7, bottom: 7, left: 13, right: 13),
        )
      ],
    );
  }
}