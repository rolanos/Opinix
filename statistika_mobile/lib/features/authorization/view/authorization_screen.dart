import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/button_widget.dart';
import 'package:statistika_mobile/core/widgets/snack_bar.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/authorization_cubit.dart';

import '../../../core/widgets/app_name_text.dart';
import '../../../core/widgets/input_widget.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({super.key});

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

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
                  'Авторизация',
                  style: context.textTheme.titleLarge,
                ),
                Column(
                  spacing: AppConstants.smallPadding,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.gray,
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
                    Text(
                      'Пароль',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.gray,
                      ),
                    ),
                    InputWidget(
                      controller: passwordController,
                      isPassword: true,
                      disableBorders: false,
                      hintText: 'Введите пароль',
                    ),
                    // Text(
                    //   'Забыли пароль?',
                    //   style: context.textTheme.bodySmall?.copyWith(
                    //     color: AppColors.gray,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(),
                BlocBuilder<AuthorizationCubit, AuthorizationState>(
                  builder: (context, state) {
                    return ButtonWidget(
                      onPressed: () {
                        context.read<AuthorizationCubit>().login(
                            emailController.text, passwordController.text);
                      },
                      text: 'Войти',
                      isLoading: state is AuthorizationLoading,
                    );
                  },
                ),
                ButtonWidget(
                  onPressed: () {
                    context.goNamed(NavigationRoutes.register);
                  },
                  type: ButtonType.underlined,
                  text: 'Зарегестрироваться',
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
