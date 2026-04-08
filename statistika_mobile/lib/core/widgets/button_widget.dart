import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/utils/utils.dart';

import '../constants/constants.dart';

enum ButtonType {
  underlined,
  filled,
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.isLoading = false,
    this.text = '',
    this.textColor,
    this.backgroundColor,
    this.onPressed,
    this.isActive = true,
    this.border,
    this.type = ButtonType.filled,
  });

  final bool isLoading;

  final String text;

  final Color? textColor;

  final Color? backgroundColor;

  final bool isActive;

  final BoxBorder? border;

  final ButtonType type;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppConstants.smallPadding,
        ),
        color: switch (type) {
          ButtonType.underlined => null,
          ButtonType.filled => backgroundColor ?? AppColors.container,
        },
        boxShadow: switch (type) {
          ButtonType.underlined => null,
          ButtonType.filled => AppTheme.shadow,
        },
        border: switch (type) {
          ButtonType.underlined => Border.all(
              color: AppColors.container,
            ),
          ButtonType.filled => null,
        },
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: isActive ? onPressed : null,
          borderRadius: BorderRadius.circular(
            AppConstants.smallPadding,
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              AppConstants.mediumPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    height: (context.textTheme.bodyMedium?.fontSize ?? 12) *
                        (context.textTheme.bodyMedium?.height ?? 1),
                    width: (context.textTheme.bodyMedium?.fontSize ?? 12) *
                        (context.textTheme.bodyMedium?.height ?? 1),
                    child: const CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  ),
                if (!isLoading)
                  Text(
                    text,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: switch (type) {
                        ButtonType.underlined =>
                          textColor ?? AppColors.container,
                        ButtonType.filled => textColor ?? AppColors.white,
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
