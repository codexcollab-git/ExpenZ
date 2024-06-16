
import 'package:balance_checker/Presentation/views/smslist/model/filter.dart';
import 'package:balance_checker/utils/config/colors/AppColors.dart';
import 'package:balance_checker/Presentation/views/common/SpaceWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/config/strings/AppStrings.dart';
import '../../common/CustomRoundedButton.dart';
import '../../common/FilterTabWidget.dart';
import '../../common/IconBorderWidget.dart';
import '../../common/TapperWidget.dart';
import '../../common/TextWidget.dart';

class FilterBottomSheetWidget extends StatelessWidget {

  String fType;
  String fFrom;
  Filter filter;
  final void Function(Filter filter)? onFilterSelected;

  FilterBottomSheetWidget({
    Key? key,
    this.fType = 'All',
    this.fFrom = 'All',
    required this.filter,
    this.onFilterSelected,
  }) : super(key: key);

  _setDefault() {
    fFrom = filter.from ?? 'All';
    fType = filter.type ?? 'All';
  }

  @override
  Widget build(BuildContext context) {
    _setDefault();
    return Container(
      height: 320,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              color: AppColors.borderColor,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                    child: Row(
                      children: [
                        FaIcon(FontAwesomeIcons.arrowDownWideShort, color: AppColors.iconLightColor, size: 16,),
                        SpaceWidget(width: 10,),
                        TextWidget(
                          str: AppStrings.filter,
                          txtColor: AppColors.iconDarkColor,
                          textAlign: TextAlign.start,
                          txtFontWeight: FontWeight.w700,
                          txtSize: 17,
                          maxLine: 1,
                          alignment: Alignment.topLeft,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(left: 20)),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 40,
                  width: 40,
                  child: TapperWidget(
                      callback: () { _close(context); },
                      child: IconBorderWidget(
                        accentColor: AppColors.iconLightColor,
                        icon: FontAwesomeIcons.xmark,
                        iconSize: 22,
                      )),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Column(
              children: [
                FilterTabWidget(
                    items: ['All', 'Account', 'Card'],
                    selectedTabBGColor: AppColors.indicatorColor,
                    tabRadius: 25,
                    selectedTabTextColor: Colors.white,
                    unSelectedBGColor: Colors.white,
                    unSelectedTabTextColor: AppColors.secondaryTextColor,
                    lastSelection: filter.from ?? 'All',
                    btnCallback: (String selection) {
                      fFrom = selection;
                    }),
                SpaceWidget(
                  height: 15,
                ),
                FilterTabWidget(
                  items: ['All', 'UPI', 'SIP', 'NEFT', 'Other'],
                  selectedTabBGColor: AppColors.indicatorColor,
                  tabRadius: 25,
                  selectedTabTextColor: Colors.white,
                  unSelectedBGColor: Colors.white,
                  unSelectedTabTextColor: AppColors.secondaryTextColor,
                  lastSelection: filter.type ?? 'All',
                  btnCallback: (String selection) {
                    fType = selection;
                  },
                ),
                SpaceWidget(
                  height: 22,
                ),
                CustomRoundedButton(btnText: AppStrings.apply,
                    height: 43,
                    btnColor: AppColors.indicatorColor,
                    btnTxtStyle: roundBtnTxtTheme(),
                    btnIcon: FaIcon(FontAwesomeIcons.circleCheck, color: Colors.white, size: 19,),
                    btnCallback: () => _onTap(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context) {
    if (onFilterSelected != null) {
      filter.from = fFrom;
      filter.type = fType;
      onFilterSelected?.call(filter);
      _close(context);
    }
  }

  void _close(BuildContext context) {
    Navigator.pop(context);
  }
}
