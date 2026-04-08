import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/widgets/button_widget.dart';
import 'package:statistika_mobile/core/widgets/snack_bar.dart';
import 'package:statistika_mobile/features/form/domain/enum/question_types.dart';
import 'package:statistika_mobile/features/general_question/view/cubit/general_question_cubit.dart';

import '../../../core/constants/routes.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/questions/single_choise_question.dart';
import '../../../core/widgets/select_modal_sheet.dart';
import '../../form/domain/model/available_answer.dart';

class GeneralQuestionScreen extends StatefulWidget {
  const GeneralQuestionScreen({super.key});

  @override
  State<GeneralQuestionScreen> createState() => _GeneralQuestionScreenState();
}

class _GeneralQuestionScreenState extends State<GeneralQuestionScreen> {
  AvailableAnswer? answer;

  @override
  void initState() {
    super.initState();
    context.read<GeneralQuestionCubit>().getGeneralQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: CustomAppBar(
          titleText: 'Вопросы',
          actions: [
            IconButton(
              onPressed: () async {
                await showSelectionModal<QuestionTypes>(
                  context,
                  QuestionTypes.values,
                  title: 'Создать вопрос',
                  onTap: (type) {
                    context.goNamed(
                      NavigationRoutes.createGeneralQuestion,
                      queryParameters: {'type': type.id},
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.mediumPadding),
        child: BlocListener<GeneralQuestionCubit, GeneralQuestionState>(
          listener: (context, state) {
            if (state is GeneralQuestionError) {
              showCustomSnackBar(
                context,
                state.message,
              );
            }
          },
          child: BlocConsumer<GeneralQuestionCubit, GeneralQuestionState>(
            listenWhen: (previous, current) {
              if (previous is GeneralQuestionInitial &&
                  current is GeneralQuestionInitial) {
                return previous.question != current.question;
              }
              return false;
            },
            listener: (context, state) {
              if (state is GeneralQuestionInitial) {
                answer = null;
                setState(() {});
              }
            },
            builder: (context, state) {
              if (state is GeneralQuestionError) {
                return CustomErrorWidget(
                  errorMessage: state.message,
                  onRefresh: () async {
                    await context
                        .read<GeneralQuestionCubit>()
                        .getGeneralQuestion(
                          emitLoading: true,
                        );
                  },
                );
              }
              if (state is GeneralQuestionLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GeneralQuestionInitial) {
                return Column(
                  spacing: AppConstants.mediumPadding,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.question != null)
                      Flexible(
                        child: SingleChoiseQuestion(
                          question: state.question!,
                          onSelected: (a) => answer = a,
                          analitic: state is GeneralQuestionInitialShowAnalitic
                              ? state.analitic
                              : null,
                        ),
                      ),
                    ButtonWidget(
                      onPressed: () async {
                        if (state is GeneralQuestionInitialAnswerLoading) {
                          return;
                        } else if (state
                            is GeneralQuestionInitialShowAnalitic) {
                          await context
                              .read<GeneralQuestionCubit>()
                              .getGeneralQuestion();
                        } else if (answer != null) {
                          await context
                              .read<GeneralQuestionCubit>()
                              .answerQuestion(answer);
                        }
                      },
                      isLoading: state is GeneralQuestionInitialAnswerLoading,
                      text: state is GeneralQuestionInitialShowAnalitic
                          ? 'Следующий вопрос'
                          : 'Ответить',
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
