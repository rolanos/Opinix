import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/constants.dart';

import '../../../../../core/model/analitical/analitical_complex.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({
    super.key,
    this.analitic,
  });

  final AnaliticComplexResult? analitic;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            flex: 3,
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: AppConstants.miniPadding,
                  centerSpaceRadius: AppConstants.largePadding * 1.5,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: widget.analitic?.data.length ?? 0,
              separatorBuilder: (context, index) => const SizedBox(
                height: AppConstants.smallPadding,
              ),
              itemBuilder: (context, index) {
                final data = widget.analitic?.data[index];
                return Row(
                  spacing: AppConstants.miniPadding,
                  children: [
                    Container(
                      color: stringToMaterialColor(data?.answerValue ?? '-'),
                      height: AppConstants.mediumPadding,
                      width: AppConstants.mediumPadding,
                    ),
                    Flexible(
                      child: Text(
                        data?.answerValue ?? 'Пусто',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.analitic?.data.length ?? 0, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: stringToMaterialColor(
          widget.analitic?.data[i].answerValue ?? '-',
        ),
        value: (widget.analitic?.data[i].count ?? 0).toDouble(),
        title: '${widget.analitic?.data[i].count ?? 0}',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          shadows: shadows,
        ),
      );
    });
  }

  Color stringToMaterialColor(String input) {
    const colors = Colors.primaries;
    return colors[input.hashCode % colors.length];
  }
}
