import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:statistika_mobile/core/model/analitical/analitical_complex.dart';
import 'package:statistika_mobile/core/utils/utils.dart';

import '../../../../../core/constants/app_constants.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({
    super.key,
    required this.analitic,
  });

  final AnaliticComplexResult? analitic;

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: calculateGeneralWidth(),
          maxHeight: context.mediaQuerySize.height * 0.22,
          minWidth:
              context.mediaQuerySize.width - AppConstants.largePadding * 3,
        ),
        child: BarChart(
          BarChartData(
            barTouchData: barTouchData,
            titlesData: titlesData,
            borderData: borderData,
            barGroups: barGroups,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              drawHorizontalLine: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.shade300,
                  strokeWidth: 1,
                );
              },
            ),
            alignment: BarChartAlignment.spaceAround,
            maxY: List<int>.generate(
                  widget.analitic?.data.length ?? 0,
                  (i) => widget.analitic?.data[i].count ?? 0,
                ).getMax().toDouble() +
                1,
          ),
        ),
      ),
    );
  }

  double calculateGeneralWidth() {
    var width = _calculateRodWidth(widget.analitic?.data.length ?? 0) *
            (widget.analitic?.data.length ?? 0) +
        (widget.analitic?.data.length ?? 0) * AppConstants.largePadding * 3;
    return max(
        width, context.mediaQuerySize.width - AppConstants.largePadding * 3);
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              context.textTheme.bodyMedium ?? const TextStyle(),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = context.textTheme.bodyLarge;
    String text;
    text = widget.analitic?.data[value.toInt()].answerValue ?? 'Пусто';
    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(
        text,
        style: style,
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: AppConstants.largePadding * 1.5
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups => List.generate(
        widget.analitic?.data.length ?? 0,
        (i) => BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: widget.analitic!.data[i].count.toDouble(),
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(
                AppConstants.smallPadding,
              ),
              width: _calculateRodWidth(widget.analitic?.data.length ?? 0),
            )
          ],
          showingTooltipIndicators: [0],
        ),
      );

  double _calculateRodWidth(int count) {
    final width = context.mediaQuerySize.width;
    if (width != 0) {
      var size = ((width - AppConstants.mediumPadding * 2) / (count * 2));
      return min(size, AppConstants.largePadding * 2);
    } else {
      return AppConstants.largePadding * 2;
    }
  }
}
