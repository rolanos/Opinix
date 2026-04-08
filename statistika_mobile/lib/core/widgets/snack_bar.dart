import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';

void showCustomSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  final snack = SnackBar(
    content: Text(
      text,
      style: context.textTheme.bodyMedium?.copyWith(
        color: AppColors.white,
      ),
    ),
    backgroundColor: AppColors.black,
    elevation: AppConstants.smallPadding,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(AppConstants.smallPadding),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
