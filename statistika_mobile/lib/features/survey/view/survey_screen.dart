import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/features/survey/view/cubit/survey_cubit.dart';

import 'widget/survey_card.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SurveyCubit>().getSurveys();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.mediumPadding),
      child: RefreshIndicator(
        onRefresh: () async => context.read<SurveyCubit>().getSurveys(),
        child: Column(
          spacing: AppConstants.mediumPadding,
          children: [
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.mediumPadding,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Поиск',
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SurveyCubit, SurveyState>(
                builder: (context, state) {
                  if (state is SurveyLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (state is SurveyInitial) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.surveys.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.mediumPadding,
                          vertical: AppConstants.mediumPadding,
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: AppConstants.mediumPadding),
                        itemBuilder: (context, index) => SurveyCard(
                          survey: state.surveys[index],
                        ),
                      );
                    }
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
