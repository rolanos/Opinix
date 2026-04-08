import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/button_widget.dart';
import 'package:statistika_mobile/core/widgets/input_widget.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/authorization_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/widgets/app_name_text.dart';
import '../../../core/widgets/snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationCubit, AuthorizationState>(
      listener: (context, state) async {
        if (state is AuthorizationAcceptRedirect) {
          context.pushNamed(NavigationRoutes.confirmEmail);
        }
        if (state is AuthorizationError && context.mounted) {
          showCustomSnackBar(context, state.message);
        }
        if (state is AuthorizationMessage && context.mounted) {
          showCustomSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.mediumPadding),
            child: Column(
              spacing: AppConstants.mediumPadding,
              children: [
                const AppNameText(),
                const Spacer(),
                Text(
                  'Регистрация',
                  style: context.textTheme.titleLarge,
                ),
                Column(
                  spacing: AppConstants.smallPadding,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Email',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.gray,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InputWidget(
                      controller: emailController,
                      disableBorders: false,
                      hintText: 'Введите почту',
                    ),
                  ],
                ),
                Column(
                  spacing: AppConstants.smallPadding,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Пароль',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.gray,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InputWidget(
                      controller: passwordController,
                      isPassword: true,
                      disableBorders: false,
                    hintText: 'Введите пароль',
                    ),
                  ],
                ),
                BlocBuilder<AuthorizationCubit, AuthorizationState>(
                  builder: (context, state) {
                    return ButtonWidget(
                      onPressed: () async {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          await context.read<AuthorizationCubit>().register(
                                emailController.text,
                                passwordController.text,
                              );
                        } else {
                          showCustomSnackBar(context, 'Заполните все поля');
                        }
                      },
                      text: 'Зарегистрироваться',
                    );
                  },
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Нажимая на кнопку, я соглашаюсь с ',
                    style: context.textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: 'политикой конфиденциальности',
                        style: context.textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            final uri = Uri.tryParse(ApiRoutes.privacyUrl);
                            if (uri != null) {
                              if (!await launchUrl(uri) && context.mounted) {
                                showCustomSnackBar(
                                  context,
                                  'Не удалось открыть политику конфиденциальности',
                                );
                              }
                            }
                          },
                      ),
                      TextSpan(
                        text: ' и ',
                        style: context.textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text: 'пользовательским соглашением',
                        style: context.textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            final uri = Uri.tryParse(ApiRoutes.termsUrl);
                            if (uri != null) {
                              if (!await launchUrl(uri) && context.mounted) {
                                showCustomSnackBar(
                                  context,
                                  'Не удалось открыть пользовательское соглашение',
                                );
                              }
                            }
                          },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
