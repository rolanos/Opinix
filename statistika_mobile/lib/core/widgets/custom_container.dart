import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/theme.dart';

import '../constants/app_constants.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
    this.margin,
    this.shadow,
    this.borderRadius,
    this.padding,
    this.color,
    this.border,
  });

  final Widget child;

  final EdgeInsets? margin;

  final EdgeInsets? padding;

  final List<BoxShadow>? shadow;

  final BorderRadiusGeometry? borderRadius;

  final Color? color;

  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(AppConstants.mediumPadding),
      decoration: BoxDecoration(
        color: color ?? AppColors.white,
        borderRadius: borderRadius ??
            BorderRadius.circular(
              AppConstants.smallPadding,
            ),
        boxShadow: shadow ?? AppTheme.shadow,
        border: border ?? Border.all(
          color: AppColors.border,
        ),
      ),
      child: child,
    );
  }
}
