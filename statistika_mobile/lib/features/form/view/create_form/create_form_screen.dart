import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/model/classifier/classifier.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/button_widget.dart';
import 'package:statistika_mobile/core/widgets/custom_app_bar.dart';
import 'package:statistika_mobile/core/widgets/input_widget.dart';
import 'package:statistika_mobile/core/widgets/snack_bar.dart';
import 'package:statistika_mobile/features/profile/cubit/user_profile_cubit.dart';
import 'package:statistika_mobile/features/form/view/create_form/cubit/create_form_cubit.dart';
import 'package:statistika_mobile/features/home/cubit/survey_types_cubit.dart';

import '../../../../core/widgets/custom_container.dart';
import '../../../../core/widgets/select_modal_sheet.dart';
import '../forms/cubit/forms_cubit.dart';

class CreateFormScreen extends StatefulWidget {
  const CreateFormScreen({super.key});

  @override
  State<CreateFormScreen> createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {
  final nameController = TextEditingController();

  final descriptionController = TextEditingController();

  final createFormCubit = CreateFormCubit();

  final nameFocus = FocusNode();

  final descriptionFocus = FocusNode();

  Classifier? type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: const CustomAppBar(titleText: 'Создание новой анкеты'),
      ),
      body: BlocProvider(
        create: (context) => createFormCubit,
        child: BlocListener<CreateFormCubit, CreateFormState>(
          bloc: createFormCubit,
          listener: (context, state) async {
            if (state is CreateFormCreated) {
              context.goNamed(
                NavigationRoutes.formEditer,
                queryParameters: {
                  'formId': state.form.id,
                },
              );
              await context.read<AllFormsCubit>().getForms();
            } else if (state is CreateFormError) {
              showCustomSnackBar(
                context,
                state.message,
              );
            }
          },
          child: Column(
            spacing: AppConstants.mediumPadding,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              CustomContainer(
                shadow: AppTheme.shadow,
                margin: const EdgeInsets.all(AppConstants.mediumPadding),
                child: Column(
                  spacing: AppConstants.miniPadding,
                  children: [
                    BlocBuilder<SurveyTypesCubit, SurveyTypesState>(
                      builder: (context, state) {
                        return Material(
                          type: MaterialType.transparency,
                          child: ListTile(
                            dense: true,
                            onTap: () async {
                              await showSelectionModal<Classifier>(
                                context,
                                state is SurveyTypesInitial
                                    ? List.generate(
                                        state.types.length,
                                        (i) => state.types[i],
                                      )
                                    : [],
                                title: 'Укажите вид опроса',
                                onTap: (value) => setState(
                                  () => type = value,
                                ),
                              );
                            },
                            title: Text(
                              type?.name ?? 'Вид опроса',
                              style: context.textTheme.bodyLarge,
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        );
                      },
                    ),
                    const Divider(
                      height: 0,
                    ),
                    InputWidget(
                      controller: nameController,
                      focusNode: nameFocus,
                      hintText: 'Название',
                    ),
                    const Divider(
                      height: 0,
                    ),
                    InputWidget(
                      controller: descriptionController,
                      focusNode: descriptionFocus,
                      hintText: 'Описание',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.mediumPadding,
                ),
                child: BlocBuilder<CreateFormCubit, CreateFormState>(
                  bloc: createFormCubit,
                  builder: (context, createFormState) {
                    return BlocBuilder<UserProfileCubit, UserProfileState>(
                      builder: (context, state) {
                        return ButtonWidget(
                          onPressed: () async {
                            if (state is UserProfileInitial &&
                                createFormState is! CreateFormLoading) {
                              await createFormCubit.createForm(
                                nameController.text,
                                descriptionController.text,
                                state.user.id,
                                type?.id,
                              );
                            }
                          },
                          isLoading: createFormState is CreateFormLoading,
                          text: 'Создать опрос',
                        );
                      },
                    );
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
