import 'package:balance_checker/Presentation/views/common/TextWidget.dart';
import 'package:balance_checker/Presentation/views/smslist/model/options.dart';
import 'package:balance_checker/utils/common/DateTimeUtils.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/config/colors/AppColors.dart';
import 'PopUpMenuTextWidget.dart';
import 'SpaceWidget.dart';
import 'TapperWidget.dart';


class CalenderDatePickerWidget extends StatefulWidget {

  List<DateTime?> selectedDates;
  final void Function(List<DateTime?> dates) onDateSelected;

  CalenderDatePickerWidget({required this.selectedDates, required this.onDateSelected});

  @override
  _CalenderDatePickerWidget createState() => _CalenderDatePickerWidget();
}

class _CalenderDatePickerWidget extends State<CalenderDatePickerWidget> {

  late CalendarDatePicker2WithActionButtonsConfig _config;
  late List<DateTime?> selectedDates;
  late Function(List<DateTime?> dates) onDateSelected;

  @override
  void initState() {
    super.initState();
    selectedDates = widget.selectedDates;
    onDateSelected = widget.onDateSelected;
  }

  @override
  void didChangeDependencies() {
    const dayTextStyle = TextStyle(color: AppColors.primaryTextColor, fontWeight: FontWeight.w700, fontFamily: 'RedditSans');
    final weekendTextStyle = TextStyle(color: AppColors.secondaryTextColor, fontWeight: FontWeight.w600, fontFamily: 'RedditSans');
    _config = CalendarDatePicker2WithActionButtonsConfig(
      calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: AppColors.indicatorColor,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      lastDate: getToday(),
      daySplashColor: Colors.transparent,
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
          textStyle = weekendTextStyle;
        }
        return textStyle;
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          print(date.day);
          dayWidget = Container(
            decoration: decoration,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    '${date.day}',
                    style: textStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 27.5),
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected == true
                            ? Colors.white
                            : Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return dayWidget;
      },
      yearBuilder: ({
        required year,
        decoration,
        isCurrentYear,
        isDisabled,
        isSelected,
        textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return _buildCalendarDialogButton(context);
  }

  _buildCalendarDialogButton(BuildContext context) {
    return TapperWidget(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      callback: () async {
        final values = await showCalendarDatePicker2Dialog(
          context: context,
          config: _config,
          dialogSize: const Size(325, 370),
          borderRadius: BorderRadius.circular(15),
          value: selectedDates,
          dialogBackgroundColor: Colors.white,
        );
        if (values != null) {
          setState(() {
            selectedDates = values;
            onDateSelected(selectedDates);
          });
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(FontAwesomeIcons.calendar, size: 15,
                  color: AppColors.indicatorColor,),
                SpaceWidget(width: 7,),
                TextWidget(str: _getDateTxt(),
                  txtColor: AppColors.primaryTextColor,
                  txtFontWeight: FontWeight.w600,
                  txtSize: 11,
                  alignment: Alignment.center,),
              ],
            ),
          )
      ),
    );
  }

  _getDateTxt() {
    String txt = '';
    if (selectedDates.length == 2 && selectedDates[0] != selectedDates[1])  {
      txt = '${getDayNameFromTimestamp(selectedDates[0]!.millisecondsSinceEpoch)} - ${getDayNameFromTimestamp(selectedDates[1]!.millisecondsSinceEpoch)}';
    } else if (selectedDates.length == 2 && selectedDates[0] == selectedDates[1])  {
      txt = '${getDayNameFromTimestamp(selectedDates[0]!.millisecondsSinceEpoch)}';
    } else if (selectedDates.length == 1) {
      txt = '${getDayNameFromTimestamp(selectedDates[0]!.millisecondsSinceEpoch)}';
    }
    return txt;
  }

  @override
  void dispose() {
    super.dispose();
  }
}