import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/features/survey/domain/model/survey/survey.dart';

class SurveyCard extends StatelessWidget {
  const SurveyCard({
    super.key,
    required this.survey,
  });

  final Survey survey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(
        NavigationRoutes.forms,
        queryParameters: {'surveyId': survey.id},
      ),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.mediumPadding),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: AppTheme.shadow,
          borderRadius: BorderRadius.circular(
            AppConstants.smallPadding,
          ),
        ),
        child: Column(
          spacing: AppConstants.smallPadding,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Spacer(),
                Icon(
                  Icons.arrow_forward,
                ),
              ],
            ),
            Text("Опрос"),
            Text(survey.id),
          ],
        ),
      ),
    );
  }
}
