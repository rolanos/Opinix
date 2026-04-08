import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/utils/utils.dart';

import '../constants/constants.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.titleText,
    this.actions = const [],
    this.bottom,
  });

  final String titleText;

  final List<Widget> actions;

  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      centerTitle: true,
      title: Text(
        titleText,
        style: context.textTheme.bodyLarge?.copyWith(color: AppColors.black),
      ),
      bottom: bottom ??
          PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Column(
              children: [
                bottom ?? const SizedBox(),
                Container(
                  height: 1,
                  color: AppColors.divider,
                ),
              ],
            ),
          ),
      actions: actions,
    );
  }
}
