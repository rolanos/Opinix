import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/utils/utils.dart';

import '../constants/app_constants.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Opinix',
      style: context.textTheme.titleLarge?.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
