import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/form/view/form_analitic/widget/pie_chart.dart';

import '../model/analitical/analitical_complex.dart';
import 'custom_container.dart';
import '../../features/form/domain/model/question.dart';
import '../../features/form/view/form_analitic/widget/bar_chart.dart';

enum AnaliticMode {
  bar('Столбчатая диаграмма'),
  pie('Круговая диаграмма');

  const AnaliticMode(this.name);

  final String name;
}

class AnaliticContainer extends StatefulWidget {
  const AnaliticContainer({
    super.key,
    required this.question,
    this.analiticResult,
  });

  final Question question;

  final AnaliticComplexResult? analiticResult;

  @override
  State<AnaliticContainer> createState() => _AnaliticContainerState();
}

class _AnaliticContainerState extends State<AnaliticContainer> {
  AnaliticMode mode = AnaliticMode.bar;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      shadow: AppTheme.shadow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstants.largePadding * 1.5,
        children: [
          Text(
            widget.question.title,
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: BarChartWidget(
              analitic: widget.analiticResult,
            ),
            secondChild: PieChartWidget(
              analitic: widget.analiticResult,
            ),
            crossFadeState: mode == AnaliticMode.bar
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
          Row(
            children: [
              DropdownButton<AnaliticMode>(
                value: mode,
                hint: const Text(
                  'Вид диаграммы',
                ),
                underline: const SizedBox(),
                style: context.textTheme.bodyMedium,
                items: List.generate(
                  AnaliticMode.values.length,
                  (i) => DropdownMenuItem(
                    value: AnaliticMode.values[i],
                    child: Row(
                      children: [Text(AnaliticMode.values[i].name)],
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value != null) {
                    setState(
                      () => mode = value,
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
