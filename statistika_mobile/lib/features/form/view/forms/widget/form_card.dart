import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/custom_container.dart';
import 'package:statistika_mobile/features/form/view/fill_form/cubit/fill_form/active_form_cubit.dart';

import '../../../domain/model/form.dart' as f;

enum FormCardViewMode {
  respondent,
  admin,
}

class FormCard extends StatelessWidget {
  const FormCard({
    super.key,
    required this.form,
    this.mode = FormCardViewMode.respondent,
  });

  final f.Form form;

  final FormCardViewMode mode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ActiveFormCubit>().init(form);
        context.pushNamed(NavigationRoutes.welcomeForm);
      },
      child: CustomContainer(
        child: Column(
          spacing: AppConstants.smallPadding,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(form.name),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward,
                ),
              ],
            ),
            Text(form.description),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Flexible(
                //   child: Text(
                //     form.createdById,
                //     style: context.textTheme.bodyMedium?.copyWith(
                //       color: AppColors.black,
                //     ),
                //   ),
                // ),
                const Spacer(),
                Text(
                  form.createdDate.toFormattedString(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            if (mode == FormCardViewMode.admin)
              Row(
                spacing: AppConstants.smallPadding,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.black,
                        ),
                      ),
                      onPressed: () {
                        context.goNamed(
                          NavigationRoutes.formEditer,
                          queryParameters: {'formId': form.id},
                        );
                      },
                      child: const Row(
                        spacing: AppConstants.smallPadding,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.black,
                        ),
                      ),
                      onPressed: () {
                        context.goNamed(
                          NavigationRoutes.formAnalitic,
                          queryParameters: {'formId': form.id},
                        );
                      },
                      child: const Row(
                        spacing: AppConstants.smallPadding,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.analytics,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: ElevatedButton(
                  //     style: const ButtonStyle(
                  //       backgroundColor: WidgetStatePropertyAll(
                  //         AppColors.blueDark,
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       context.goNamed(
                  //         NavigationRoutes.surveyConfiguration,
                  //         queryParameters: {'surveyId': form.surveyId},
                  //       );
                  //     },
                  //     child: const Row(
                  //       spacing: AppConstants.smallPadding,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(
                  //           Icons.settings,
                  //           color: AppColors.white,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
