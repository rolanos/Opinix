import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/utils/utils.dart';
import 'package:statistika_mobile/core/widgets/custom_container.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

class QuestionContainerLong extends StatelessWidget {
  const QuestionContainerLong({
    super.key,
    required this.question,
    this.showModerateIndicator = true,
  });

  final bool showModerateIndicator;

  final Question question;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      shadow: AppTheme.shadow,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstants.mediumPadding,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  question.title,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (!question.isModerated && showModerateIndicator)
                Text(
                  'На модерации',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          Flexible(
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: question.availableAnswers.length,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (context, index) => Builder(builder: (context) {
                  return Row(
                    spacing: AppConstants.mediumPadding,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: AppConstants.largePadding,
                        ),
                        child: Text(
                          '$index.',
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          question.availableAnswers[index].text ?? 'Пустой ответ',
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
