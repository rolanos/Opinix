import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/utils.dart';
import 'package:statistika_mobile/core/widgets/custom_container.dart';
import 'package:statistika_mobile/core/widgets/dialog.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';
import 'package:statistika_mobile/features/my_general_questions/cubit/my_general_questions_cubit.dart';

class QuestionContainerShort extends StatelessWidget {
  const QuestionContainerShort({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          NavigationRoutes.questionScreen,
          queryParameters: {
            'question_id': question.id,
          },
        );
      },
      child: CustomContainer(
        shadow: AppTheme.shadow,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppConstants.smallPadding,
          children: [
            Row(
              spacing: AppConstants.smallPadding,
              children: [
                Expanded(
                  child: Text(
                    question.title,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (!question.isModerated)
                  Text(
                    'На модерации',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                IconButton(
                  onPressed: () async {
                    final result = await showCustomDialog(
                      context,
                      'Удалить вопрос',
                      'Вы уверены, что хотите удалить вопрос?',
                    );
                    if (result && context.mounted) {
                      context.read<MyGeneralQuestionsCubit>().deleteQuestion(
                            question,
                          );
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
