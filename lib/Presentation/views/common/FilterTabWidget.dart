

import 'package:balance_checker/Presentation/views/common/TextWidget.dart';
import 'package:flutter/material.dart';

import '../../../utils/config/colors/AppColors.dart';


class FilterTabWidget extends StatefulWidget {
  final Color unSelectedTabTextColor;
  final Color selectedTabTextColor;
  final Color selectedTabBGColor;
  final Color unSelectedBGColor;
  final List<String> items;
  final double tabRadius;
  final String lastSelection;
  final ValueSetter<String> btnCallback;

  FilterTabWidget({Key? key, required this.items, this.tabRadius = 25,
    required this.selectedTabTextColor, required this.selectedTabBGColor,
    required this.unSelectedTabTextColor, required this.lastSelection,
    required this.unSelectedBGColor, required this.btnCallback}) : super(key: key);

  @override
  _FilterTabWidget createState() => _FilterTabWidget();
}

class _FilterTabWidget extends State<FilterTabWidget> {

  late Color unSelectedTabTextColor;
  late Color selectedTabTextColor;
  late Color selectedTabBGColor;
  late Color unSelectedBGColor;
  late List<String> items;
  late double tabRadius;
  late String lastSelection;
  late ValueSetter<String> btnCallback;

  @override
  void initState() {
    super.initState();
    unSelectedTabTextColor = widget.unSelectedTabTextColor;
    selectedTabTextColor = widget.selectedTabTextColor;
    selectedTabBGColor = widget.selectedTabBGColor;
    unSelectedBGColor = widget.unSelectedBGColor;
    items = widget.items;
    tabRadius = widget.tabRadius;
    lastSelection = widget.lastSelection;
    btnCallback = widget.btnCallback;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Row(
        children: [
          for (var item in items) _drawTab(item),
        ],
      ),
    );
  }

  _drawTab(String txt) {
    if (txt == lastSelection) {
      return _tab(txt, true);
    } else {
      return _tab(txt, false);
    }
  }

  _tab(String txt, bool selected) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          if (lastSelection != txt) {
            btnCallback(txt);
            setState(() {
              lastSelection = txt;
            });
          }
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: selected ? selectedTabBGColor : unSelectedBGColor,
              borderRadius: BorderRadius.circular(tabRadius),
              boxShadow: [ _addShadow(selected)],
          ),
          child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              child: TextWidget(str: txt, txtFontWeight: FontWeight.w700, txtColor: selected ? selectedTabTextColor : unSelectedTabTextColor, txtSize: 12, textAlign: TextAlign.center, maxLine: 1, alignment: Alignment.center,)
          ),
        ),
      ),
    );
  }

  _addShadow(bool selected) {
    if (selected) {
      return BoxShadow(
        color: selectedTabBGColor,
        blurRadius: 0.0,
      );
    } else {
      return BoxShadow( blurRadius: 0, color: unSelectedBGColor);
    }
  }
}