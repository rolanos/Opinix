import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/utils/utils.dart';
import 'package:statistika_mobile/core/widgets/analitic_container.dart';
import 'package:statistika_mobile/core/widgets/custom_app_bar.dart';

import '../../core/constants/app_constants.dart';
import 'cubit/question_cubit.dart';
import '../../core/widgets/questions/question_container_long.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final questionCubit = QuestionCubit();

  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        questionCubit.getQuestion(
          context.getQueryValueOrNull(
            'question_id',
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => questionCubit,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: const CustomAppBar(
            titleText: 'Вопрос',
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return questionCubit.getQuestion(
              context.getQueryValueOrNull(
                'question_id',
              ),
            );
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(
              AppConstants.mediumPadding,
            ),
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: context.mediaQuerySize.height * 0.7,
              ),
              child: BlocBuilder<QuestionCubit, QuestionState>(
                bloc: questionCubit,
                builder: (context, state) {
                  if (state is QuestionLoading) {
                    return const Center(
                      child: Padding(
                        padding:
                            EdgeInsetsGeometry.all(AppConstants.mediumPadding),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Column(
                    spacing: AppConstants.mediumPadding,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is QuestionError)
                        Text(
                          state.message,
                          style: context.textTheme.bodyMedium,
                        ),
                      if (state is QuestionInitialLoaded)
                        QuestionContainerLong(
                          question: state.question,
                        ),
                      if (state is! QuestionError && state is! QuestionEmpty)
                        Text(
                          'Аналитика',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (state is QuestionInitial)
                        AnaliticContainer(
                          question: state.question,
                          analiticResult: state.analitical,
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
