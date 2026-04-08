import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/utils/utils.dart';

import '../constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.titleText,
    this.actions = const [],
  });

  final String titleText;

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      centerTitle: true,
      flexibleSpace: SizedBox(),
      title: Text(
        titleText,
        style: context.textTheme.bodyLarge?.copyWith(color: AppColors.black),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppColors.divider,
        ),
      ),
      actions: actions,
    );
  }
}
