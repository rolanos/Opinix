import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/widgets/questions_create_template/single_choise_create.dart';
import 'package:statistika_mobile/features/form/domain/enum/question_types.dart';
import 'package:statistika_mobile/features/form/domain/model/section.dart';
import 'package:statistika_mobile/features/form/view/form_editer/cubit/form_editer_cubit.dart';

import '../../../../../core/widgets/questions_create_template/multiple_choise_create.dart';

class SectionContent extends StatelessWidget {
  const SectionContent({
    super.key,
    required this.section,
  });

  final Section section;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: section.questions.length,
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppConstants.mediumPadding),
        itemBuilder: (context, index) =>
            switch (QuestionTypes.tryParse(section.questions[index].typeId)) {
              QuestionTypes.singleChoise => SingleChoiseCreateWidget(
                  key: ValueKey(section.questions[index].id),
                  updateDuration: const Duration(milliseconds: 500),
                  onDeleteQuestion: (q) async =>
                      context.read<FormEditerCubit>().deleteQuestion(q),
                  onAddAnswer: () async => context
                      .read<FormEditerCubit>()
                      .addAvailableAnswer(section.questions[index]),
                  onUpdateTitle: (title) async =>
                      context.read<FormEditerCubit>().updateQuestion(
                            section.questions[index],
                            title: title,
                          ),
                  onDeleteAvailableAnswer: (available) async => context
                      .read<FormEditerCubit>()
                      .deleteAvailableAnswer(available),
                  onUpdateAvailableAnswer: (q, text) =>
                      context.read<FormEditerCubit>().updateAvailableAnswer(
                            q,
                            text: text,
                          ),
                  question: section.questions[index],
                ),
              QuestionTypes.multipleChoice => MultipleChoiseCreateWidget(
                  key: ValueKey(section.questions[index].id),
                  updateDuration: const Duration(milliseconds: 500),
                  onDeleteQuestion: (q) async =>
                      context.read<FormEditerCubit>().deleteQuestion(q),
                  onAddAnswer: () async => context
                      .read<FormEditerCubit>()
                      .addAvailableAnswer(section.questions[index]),
                  onUpdateTitle: (title) async =>
                      context.read<FormEditerCubit>().updateQuestion(
                            section.questions[index],
                            title: title,
                          ),
                  onDeleteAvailableAnswer: (available) async => context
                      .read<FormEditerCubit>()
                      .deleteAvailableAnswer(available),
                  onUpdateAvailableAnswer: (q, text) =>
                      context.read<FormEditerCubit>().updateAvailableAnswer(
                            q,
                            text: text,
                          ),
                  question: section.questions[index],
                ),
              null => const SizedBox(),
            });
  }
}
