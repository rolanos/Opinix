import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/button_widget.dart';
import 'package:statistika_mobile/features/form/view/fill_form/cubit/fill_form/active_form_cubit.dart';
import 'package:statistika_mobile/features/form/view/fill_form/cubit/fill_form/fill_form_cubit.dart';

import '../../../../core/constants/routes.dart';

class WelcomeFormScreen extends StatefulWidget {
  const WelcomeFormScreen({super.key});

  @override
  State<WelcomeFormScreen> createState() => _WelcomeFormScreenState();
}

class _WelcomeFormScreenState extends State<WelcomeFormScreen> {
  final fillFormCubit = FillFormCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => fillFormCubit,
        child: BlocConsumer<FillFormCubit, FillFormState>(
          bloc: fillFormCubit,
          listener: (context, state) {
            if (state is FillFormInitial) {
              context.goNamed(NavigationRoutes.fillForm, extra: fillFormCubit);
            }
          },
          builder: (context, fillFormState) {
            return BlocBuilder<ActiveFormCubit, ActiveFormState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: AppConstants.smallPadding,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.form?.name ?? '',
                          style: context.textTheme.titleLarge!
                              .copyWith(color: AppColors.black)),
                      ButtonWidget(
                        onPressed: () async {
                          await fillFormCubit.start(state.form?.id);
                        },
                        isLoading: fillFormState is FillFormLoading,
                        text: 'Начать анкету',
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
