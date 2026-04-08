import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/widgets/button_widget.dart';
import 'package:statistika_mobile/core/widgets/custom_app_bar.dart';

import '../../core/widgets/dialog.dart';
import '../../core/widgets/error_widget.dart';
import '../../core/widgets/questions/question_container_long.dart';
import '../../core/widgets/questions/question_container_short.dart';
import 'cubit/moderation_cubit.dart';

class ModerationScreen extends StatefulWidget {
  const ModerationScreen({super.key});

  @override
  State<ModerationScreen> createState() => _ModerationScreenState();
}

class _ModerationScreenState extends State<ModerationScreen> {
  final moderationCubit = ModerationCubit();

  @override
  void initState() {
    super.initState();
    moderationCubit.getGeneralQuestionForModerate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: const CustomAppBar(titleText: 'Модерация вопроса'),
      ),
      body: BlocProvider(
        create: (context) => moderationCubit,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.mediumPadding),
          child: BlocBuilder<ModerationCubit, ModerationState>(
            bloc: moderationCubit,
            builder: (context, state) {
              return Column(
                spacing: AppConstants.mediumPadding,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is ModerationInitial)
                    QuestionContainerLong(
                      question: state.question,
                      showModerateIndicator: false,
                    ),
                  if (state is ModerationLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (state is ModerationError)
                    CustomErrorWidget(
                      errorMessage: state.message,
                      onRefresh: () async {
                        await moderationCubit.getGeneralQuestionForModerate();
                      },
                    ),
                  if (state is ModerationInitial)
                    Row(
                      spacing: AppConstants.mediumPadding,
                      children: [
                        Expanded(
                          child: ButtonWidget(
                            text: 'Отклонить',
                            backgroundColor: AppColors.red,
                            onPressed: () async {
                              final result = await showCustomDialog(
                                context,
                                'Отклонить вопрос',
                                'Вы уверены, что хотите отклонить данный вопрос?',
                              );
                              if (result) {
                                await moderationCubit.moderate(false);
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: ButtonWidget(
                            text: 'Принять',
                            onPressed: () async {
                              final result = await showCustomDialog(
                                context,
                                'Принять вопрос',
                                'Вы уверены, что хотите принять данный вопрос?',
                              );
                              if (result) {
                                await moderationCubit.moderate(true);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
