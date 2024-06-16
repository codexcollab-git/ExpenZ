
import 'dart:math';

import 'package:balance_checker/Presentation/views/common/SpaceWidget.dart';
import 'package:balance_checker/utils/common/CommonUtils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../utils/config/colors/AppColors.dart';
import '../views/common/IndicatorWidget.dart';
import '../views/smslist/model/plots.dart';

class DrawExpensePieChart extends StatefulWidget {
  List<Plots> plots;

  DrawExpensePieChart({Key? key, required this.plots}) : super(key: key);

  @override
  _DrawExpensePieChart createState() => _DrawExpensePieChart();
}

class _DrawExpensePieChart extends State<DrawExpensePieChart> {

  late List<Plots> plots;

  @override
  void initState() {
    super.initState();
    plots = widget.plots;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 120,
          child: PieChart(
            PieChartData(
              sectionsSpace: 3,
              centerSpaceRadius: 0,
              sections: showingExpenseSections(),
            ),
          ),
        ),
        SpaceWidget(height: 10,),
        Container(
          width: 100,
          margin: EdgeInsets.only(left: 15, bottom: 10),
          child: Column(
            children: <Widget>[
              for (Plots plot in plots) _drawIndicators(plot),
            ],
          ),
        ),
      ],
    );
  }

  _drawIndicators(
      Plots plot,
      ) {
    Color? color = null;
    switch (plot.type) {
      case 'Earning':
        {
          color = AppColors.chartColorGreen;
          break;
        }
      case 'Expense':
        {
          color = AppColors.chartColorRed;
          break;
        }
    }
    return IndicatorWidget(
        accentColor: color!,
        heading: '${plot.type}');
  }

  List<PieChartSectionData> showingExpenseSections() {
    return List.generate(plots.length, (i) {
      final fontSize = 14.0;
      final radius = 50.0;
      final fontFamily = 'RedditSans';
      const shadows = [Shadow(color: Colors.black, blurRadius: 3)];
      final TextStyle style = TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        shadows: shadows,
      );
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.chartColorRed,
            value: plots[0].percent,
            title: '₹ ${formatAmount(plots[0].amount)}',
            radius: radius,
            titleStyle: style,
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.chartColorGreen,
            value: plots[1].percent,
            title: '₹ ${formatAmount(plots[1].amount)}',
            radius: radius,
            titleStyle: style,
          );
        default:
          throw Error();
      }
    });
  }
}