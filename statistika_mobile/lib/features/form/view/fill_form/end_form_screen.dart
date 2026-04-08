import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';

import '../../../../core/constants/app_constants.dart';

class EndFormScreen extends StatelessWidget {
  const EndFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          pinned: true,
          stretch: true,
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          centerTitle: true,
          title: Text(
            'Профиль',
            style:
                context.textTheme.bodyLarge?.copyWith(color: AppColors.black),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Спасибо за прохождение формы,\nформа успешно отправлена',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
