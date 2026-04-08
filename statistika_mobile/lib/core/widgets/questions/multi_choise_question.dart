import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';

import '../../../features/form/domain/model/available_answer.dart';
import '../../../features/form/domain/model/question.dart';
import '../../constants/app_constants.dart';
import '../../constants/theme.dart';
import '../../model/analitical/analitical_complex.dart';

class MultiChoiseQuestion extends StatefulWidget {
  const MultiChoiseQuestion({
    super.key,
    required this.question,
    required this.onSelected,
    required this.onUnselected,
    this.analitic,
    this.availableAnswers = const [],
  });

  final Question question;

  final List<AvailableAnswer> availableAnswers;

  final AnaliticComplexResult? analitic;

  final Function(AvailableAnswer?) onSelected;

  final Function(AvailableAnswer?) onUnselected;

  @override
  State<MultiChoiseQuestion> createState() => _MultiChoiseQuestionState();
}

class _MultiChoiseQuestionState extends State<MultiChoiseQuestion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.mediumPadding),
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: AppTheme.shadow,
        borderRadius: BorderRadius.circular(AppConstants.mediumPadding),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppConstants.largePadding,
        children: [
          Container(
            padding: const EdgeInsets.all(
              AppConstants.mediumPadding,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppConstants.mediumPadding,
              ),
            ),
            child: Text(
              widget.question.title,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.question.availableAnswers.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: AppConstants.mediumPadding),
            itemBuilder: (context, index) => Builder(builder: (context) {
              final availableAnswer = widget.question.availableAnswers[index];
              final contains = widget.availableAnswers
                  .where(
                    (e) => e.id == availableAnswer.id,
                  )
                  .isNotEmpty;
              final analiticResult = widget.analitic?.findByAnswerIdSingle(
                availableAnswer.id,
              );
              return Container(
                padding: const EdgeInsets.all(
                  AppConstants.smallPadding,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppConstants.mediumPadding,
                  ),
                ),
                child: Column(
                  spacing: AppConstants.smallPadding,
                  children: [
                    CheckboxListTile(
                      value: contains,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        widget.question.availableAnswers[index].text ??
                            'Пустой ответ',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onChanged: (value) {
                        if (value == true) {
                          widget.onSelected(availableAnswer);
                        } else {
                          widget.onUnselected(availableAnswer);
                        }
                      },
                    ),
                    if (widget.analitic != null &&
                        analiticResult != null &&
                        widget.analitic?.totalCount != null &&
                        widget.analitic?.totalCount != 0)
                      LinearProgressIndicator(
                        value: analiticResult.count /
                            (widget.analitic?.totalCount ?? 1),
                        backgroundColor: AppColors.whiteSecondary,
                        borderRadius: BorderRadius.circular(
                          AppConstants.miniPadding,
                        ),
                        minHeight: 6,
                      ),
                    if (widget.analitic != null &&
                        analiticResult != null &&
                        widget.analitic?.totalCount != null &&
                        widget.analitic?.totalCount != 0)
                      Row(
                        children: [
                          Text(
                            '${analiticResult.count}/${widget.analitic?.totalCount ?? 1}',
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: AppColors.gray),
                          ),
                          const Spacer(),
                          Text(
                            '${(100 * (analiticResult.count / (widget.analitic?.totalCount ?? 1))).toStringAsFixed(0)}%',
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: AppColors.gray),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
