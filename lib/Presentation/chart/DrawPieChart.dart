import 'dart:math';

import 'package:balance_checker/Presentation/views/common/EmptyWidget.dart';
import 'package:balance_checker/Presentation/views/common/IndicatorWidget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../utils/common/CommonUtils.dart';
import '../../utils/config/colors/AppColors.dart';
import '../views/smslist/model/plots.dart';

class DrawPieChart extends StatefulWidget {
  List<Plots> plots;

  DrawPieChart({Key? key, required this.plots}) : super(key: key);

  @override
  _DrawPieChart createState() => _DrawPieChart();
}

class _DrawPieChart extends State<DrawPieChart> {
  List<Color> usedColor = [];
  late List<Plots> plots;

  @override
  void initState() {
    super.initState();
    plots = widget.plots;
  }

  @override
  Widget build(BuildContext context) {
    for (Plots plot in plots) {
      Color _color = _getUniqueRandomColor();
      plot.color = _color;
    }

    return Stack(
      children: [
        Container(
          height: 300,
          width: 300,
          child: PieChart(
            PieChartData(
              sectionsSpace: 3,
              centerSpaceRadius: 42,
              sections: showingTypeSections(),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (Plots plot in plots)
                _drawIndicators(plot),
            ],
          ),
        )
      ],
    );
  }

  _drawIndicators(
    Plots plot,
  ) {
    return IndicatorWidget(
        accentColor: plot.color!,
        heading: '${plot.type}');
  }

  List<PieChartSectionData> showingTypeSections() {
    usedColor.clear();
    return List.generate(plots.length, (i) {
      final fontSize = 12.0;
      final radius = 42.0;
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
            color: plots[0].color,
            value: plots[0].percent,
            title: '₹ ${formatAmount(plots[0].amount)}',
            radius: radius,
            titleStyle: style,
          );
        case 1:
          return PieChartSectionData(
            color: plots[1].color,
            value: plots[1].percent,
            title: '₹ ${formatAmount(plots[1].amount)}',
            radius: radius,
            titleStyle: style,
          );
        case 2:
          return PieChartSectionData(
            color: plots[2].color,
            value: plots[2].percent,
            title: '₹ ${formatAmount(plots[2].amount)}',
            radius: radius,
            titleStyle: style,
          );
        case 3:
          return PieChartSectionData(
            color: plots[3].color,
            value: plots[3].percent,
            title: '₹ ${formatAmount(plots[3].amount)}',
            radius: radius,
            titleStyle: style,
          );
        default:
          throw Error();
      }
    });
  }

  Color _getUniqueRandomColor() {
    List<Color> colors = [
      AppColors.chartColorYellow,
      AppColors.chartColorGreen,
      AppColors.chartColorDarkBlue,
      AppColors.chartColorPink,
      AppColors.chartColorPurple,
      AppColors.chartColorRed,
      AppColors.chartColorLightBlue,
    ];

    Random random = Random();
    int randomIndex = random.nextInt(colors.length);
    Color color = colors[randomIndex];
    if (usedColor.contains(color)) {
      color = _getUniqueRandomColor();
    } else {
      usedColor.add(color);
    }
    return color;
  }
}
