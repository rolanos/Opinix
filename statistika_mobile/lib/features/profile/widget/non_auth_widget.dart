import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/custom_container.dart';

import '../../../core/widgets/button_widget.dart';
import '../../authorization/view/cubit/authorization_cubit.dart';

class NonAuthWidget extends StatelessWidget {
  const NonAuthWidget({
    super.key,
    this.isLoading = false,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: CustomContainer(
        margin: EdgeInsets.symmetric(
          vertical: context.mediaQuerySize.height * 0.25,
          horizontal: AppConstants.mediumPadding,
        ),
        child: Column(
          spacing: AppConstants.mediumPadding,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Войти в профиль',
              style: context.textTheme.titleMedium,
            ),
            ButtonWidget(
              onPressed: () async {
                if (context.mounted) {
                  await context.read<AuthorizationCubit>().logout();
                }
              },
              text: 'Авторизоваться',
              backgroundColor: AppColors.red,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
