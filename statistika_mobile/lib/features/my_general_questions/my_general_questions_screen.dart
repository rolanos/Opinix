import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/utils/utils.dart';
import 'package:statistika_mobile/core/widgets/custom_app_bar.dart';
import 'package:statistika_mobile/core/widgets/snack_bar.dart';

import '../../core/constants/constants.dart';
import '../../core/constants/routes.dart';
import '../../core/widgets/button_widget.dart';
import '../../core/widgets/select_modal_sheet.dart';
import '../form/domain/enum/question_types.dart';
import 'cubit/my_general_questions_cubit.dart';
import '../../core/widgets/questions/question_container_short.dart';

class MyGeneralQuestionsScreen extends StatefulWidget {
  const MyGeneralQuestionsScreen({super.key});

  @override
  State<MyGeneralQuestionsScreen> createState() =>
      _MyGeneralQuestionsScreenState();
}

class _MyGeneralQuestionsScreenState extends State<MyGeneralQuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: const CustomAppBar(
          titleText: 'Мои вопросы',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return context
              .read<MyGeneralQuestionsCubit>()
              .getMyGeneralQuestions();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppConstants.mediumPadding),
          child: BlocConsumer<MyGeneralQuestionsCubit, MyGeneralQuestionsState>(
            listener: (context, state) {
              if (state is MyGeneralQuestionsError) {
                showCustomSnackBar(
                  context,
                  state.message,
                );
              }
            },
            builder: (context, state) {
              if (state is MyGeneralQuestionsEmpty ||
                  (state is MyGeneralQuestionsInitial &&
                      state.questions.isEmpty)) {
                return Column(
                  spacing: AppConstants.smallPadding,
                  children: [
                    Text(
                      'Вы ещё не создали ни один вопрос. Самое время начать!',
                      style: context.textTheme.bodyLarge,
                    ),
                    ButtonWidget(
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
                      text: 'Перейти к созданию',
                    ),
                  ],
                );
              }
              if (state is MyGeneralQuestionsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is MyGeneralQuestionsInitial) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.questions.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: AppConstants.mediumPadding,
                  ),
                  itemBuilder: (context, index) => QuestionContainerShort(
                    question: state.questions[index],
                  ),
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
