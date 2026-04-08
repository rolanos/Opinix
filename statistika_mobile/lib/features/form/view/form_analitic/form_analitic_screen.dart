import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/utils/utils.dart';
import 'package:statistika_mobile/features/form/view/form_analitic/cubit/form_analitic_cubit.dart';
import 'package:statistika_mobile/core/widgets/analitic_container.dart';

class FormAnaliticScreen extends StatefulWidget {
  const FormAnaliticScreen({
    super.key,
    this.formId,
  });

  final String? formId;

  @override
  State<FormAnaliticScreen> createState() => _FormAnaliticScreenState();
}

class _FormAnaliticScreenState extends State<FormAnaliticScreen> {
  final formAnaliticCubit = FormAnaliticCubit();

  RangeValues rangeValues = const RangeValues(1, 99);

  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  @override
  void initState() {
    super.initState();
    formAnaliticCubit.update(widget.formId);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: false,
          pinned: true,
          floating: true,
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          title: Text(
            'Аналитика',
            style:
                context.textTheme.bodyLarge?.copyWith(color: AppColors.black),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.mediumPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: AppConstants.smallPadding,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Checkbox(
                      value: isMaleSelected,
                      onChanged: (value) async {
                        setState(() {
                          isMaleSelected = value!;
                        });
                        await formAnaliticCubit.update(
                          widget.formId,
                          isMan: isMaleSelected,
                          isWoman: isFemaleSelected,
                          startAge: rangeValues.start.toInt(),
                          endAge: rangeValues.end.toInt(),
                        );
                      },
                    ),
                    Text(
                      'Мужчина',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(),
                    Checkbox(
                      value: isFemaleSelected,
                      onChanged: (value) async {
                        setState(() {
                          isFemaleSelected = value!;
                        });
                        await formAnaliticCubit.update(
                          widget.formId,
                          isMan: isMaleSelected,
                          isWoman: isFemaleSelected,
                          startAge: rangeValues.start.toInt(),
                          endAge: rangeValues.end.toInt(),
                        );
                      },
                    ),
                    Text(
                      'Женщина',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Возраст ${rangeValues.start.toInt()}-${rangeValues.end.toInt()}',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                  ),
                ),
                RangeSlider(
                  values: rangeValues,
                  min: 1,
                  max: 99,
                  activeColor: AppColors.blue,
                  overlayColor:
                      const WidgetStatePropertyAll(AppColors.whiteSecondary),
                  labels: const RangeLabels('1 лет', '99 лет'),
                  onChanged: (values) async {
                    setState(() {
                      rangeValues = values;
                    });
                    await formAnaliticCubit.update(
                      widget.formId,
                      isMan: isMaleSelected,
                      isWoman: isFemaleSelected,
                      startAge: rangeValues.start.toInt(),
                      endAge: rangeValues.end.toInt(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: BlocProvider(
            create: (context) => formAnaliticCubit,
            child: BlocBuilder<FormAnaliticCubit, FormAnaliticState>(
              bloc: formAnaliticCubit,
              builder: (context, state) {
                if (state is FormAnaliticLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is FormAnaliticInitial) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.questions.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppConstants.smallPadding),
                    itemBuilder: (context, index) => AnaliticContainer(
                      question: state.questions[index],
                      analiticResult:
                          state.getAnaliticResult(state.questions[index].id),
                    ),
                    // SingleChoiseQuestion(
                    //   question: state.questions[index],
                    //   onSelected: (_) {},
                    //   analitic: state.getAnaliticResult(
                    //     state.questions[index].id,
                    //   ),
                    // ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ],
    );
  }
}
