import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/utils/utils.dart';
import 'package:statistika_mobile/core/widgets/button_widget.dart';
import 'package:statistika_mobile/core/widgets/snack_bar.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/authorization_cubit.dart';

import '../../../core/constants/routes.dart';
import '../../../core/widgets/app_name_text.dart';

class EmailCodeAccept extends StatefulWidget {
  const EmailCodeAccept({super.key});

  @override
  State<EmailCodeAccept> createState() => _EmailCodeAcceptState();
}

class _EmailCodeAcceptState extends State<EmailCodeAccept> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthorizationCubit, AuthorizationState>(
          listener: (context, state) async {
        if (state is AuthorizationInited) {
          context.goNamed(NavigationRoutes.generalQuestions);
        }
        if (state is AuthorizationAcceptError) {
          if (context.mounted) {
            showCustomSnackBar(
              context,
              state.errorMessage,
            );
          }
        }
      }, builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
              AppConstants.mediumPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppNameText(),
                const Spacer(
                  flex: 2,
                ),
                if (state is AuthorizationAcceptEmail)
                  RichText(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '${state.message.message} ',
                      style: context.textTheme.bodyMedium,
                      children: <TextSpan>[
                        if (state.message.email != null)
                          TextSpan(
                            text: state.message.email,
                            style: context.textTheme.titleMedium,
                          ),
                      ],
                    ),
                  ),
                const Spacer(
                  flex: 2,
                ),
                Center(
                  child: Pinput(
                    length: 6,
                    controller: controller,
                    onChanged: (value) {
                      setState(() {});
                    },
                    onCompleted: (value) async {
                      await context
                          .read<AuthorizationCubit>()
                          .confirmEmail(value);
                    },
                  ),
                ),
                const Spacer(),
                ButtonWidget(
                  isActive: controller.text.length == 6,
                  isLoading: state is AuthorizationAcceptLoading,
                  text: 'Отправить',
                  backgroundColor: state is AuthorizationAcceptLoading
                      ? AppColors.black
                      : null,
                  onPressed: () async {
                    await context.read<AuthorizationCubit>().confirmEmail(
                          controller.text,
                        );
                  },
                ),
                // const Spacer(),
                // Text(
                //   'Прислать код заново',
                //   style: context.textTheme.bodyMedium,
                // ),
                const Spacer(
                  flex: 4,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
