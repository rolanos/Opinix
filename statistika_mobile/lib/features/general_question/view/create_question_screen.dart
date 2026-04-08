import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/widgets/button_widget.dart';
import 'package:statistika_mobile/core/widgets/custom_app_bar.dart';
import 'package:statistika_mobile/core/widgets/questions_create_template/single_choise_create.dart';
import 'package:statistika_mobile/core/widgets/snack_bar.dart';
import 'package:statistika_mobile/features/form/domain/enum/question_types.dart';
import 'package:statistika_mobile/features/general_question/view/cubit/create_question_cubit.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/questions_create_template/multiple_choise_create.dart';

class CreateQuestionScreen extends StatefulWidget {
  const CreateQuestionScreen({super.key, this.type});

  final String? type;

  @override
  State<CreateQuestionScreen> createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final createQuestionCubit = CreateQuestionCubit();

  late final QuestionTypes? type;

  @override
  void initState() {
    super.initState();
    type = QuestionTypes.tryParse(widget.type);

    createQuestionCubit.init(type?.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: const CustomAppBar(
          titleText: 'Создание вопроса',
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight -
                  AppBar().preferredSize.height +
                  AppConstants.largePadding,
            ),
            child: BlocProvider(
              create: (context) => createQuestionCubit,
              child: BlocConsumer<CreateQuestionCubit, CreateQuestionState>(
                bloc: createQuestionCubit,
                listener: (context, state) {
                  if (state is CreateQuestionSendSuccess) {
                    showCustomSnackBar(
                      context,
                      state.response.message,
                    );
                    context.goNamed(NavigationRoutes.generalQuestions);
                  }
                },
                builder: (context, state) {
                  if (state is CreateQuestionInitial) {
                    return Padding(
                      padding: const EdgeInsets.all(AppConstants.mediumPadding),
                      child: Column(
                        spacing: AppConstants.largePadding,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (type?.name != null)
                            Text(
                              type!.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          switch (type) {
                            QuestionTypes.singleChoise =>
                              SingleChoiseCreateWidget(
                                question: state.question,
                                onUpdateTitle: (title) => createQuestionCubit
                                    .changeQuestionTitle(title),
                                onAddAnswer: () =>
                                    createQuestionCubit.addAnswer(),
                                onUpdateAvailableAnswer: (answer, text) =>
                                    createQuestionCubit.updateAnswer(
                                  answer,
                                  text,
                                ),
                                onDeleteAvailableAnswer: (answer) =>
                                    createQuestionCubit.deleteAnswer(answer),
                                updateDuration: Duration.zero,
                              ),
                            QuestionTypes.multipleChoice =>
                              MultipleChoiseCreateWidget(
                                question: state.question,
                                onUpdateTitle: (title) => createQuestionCubit
                                    .changeQuestionTitle(title),
                                onAddAnswer: () =>
                                    createQuestionCubit.addAnswer(),
                                onUpdateAvailableAnswer: (answer, text) =>
                                    createQuestionCubit.updateAnswer(
                                  answer,
                                  text,
                                ),
                                onDeleteAvailableAnswer: (answer) =>
                                    createQuestionCubit.deleteAnswer(answer),
                                updateDuration: Duration.zero,
                              ),
                            null => const SizedBox(),
                          },
                          if (createQuestionCubit.canCreateQuestion())
                            ButtonWidget(
                              onPressed: () =>
                                  createQuestionCubit.addNewQuestion(),
                              text: 'Создать',
                              isLoading: state is CreateQuestionSendLoading,
                            ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
