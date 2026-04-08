import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';
import 'package:statistika_mobile/core/widgets/button_widget.dart';

import '../../../core/widgets/app_name_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: AppConstants.mediumPadding,
            ),
            const AppNameText(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Lottie.asset(
                      'assets/welcome_animation.json',
                      repeat: true,
                    ),
                  ),
                  Text(
                    'Создавайте и узнавайте мнение окружения прямо сейчас!',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.mediumPadding),
              child: Column(
                spacing: AppConstants.mediumPadding,
                children: [
                  ButtonWidget(
                    onPressed: () {
                      context.goNamed(NavigationRoutes.auth);
                    },
                    text: 'Авторизация',
                  ),
                  ButtonWidget(
                    onPressed: () async {
                      await SharedPreferencesManager.clear();
                      await SharedPreferencesManager.setAnonymous();
                      if (context.mounted) {
                        context.goNamed(NavigationRoutes.generalQuestions);
                      }
                    },
                    text: 'Анонимный вход',
                    type: ButtonType.underlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
