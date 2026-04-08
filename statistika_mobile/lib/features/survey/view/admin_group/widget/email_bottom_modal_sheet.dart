import 'dart:async';

import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/button_widget.dart';

Future<void> showEmailBottomSheet(
  BuildContext context, {
  FutureOr<void> Function(String)? onTap,
}) async {
  final TextEditingController _emailController = TextEditingController();

  bool isLoading = false;

  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true, // Для правильного отображения клавиатуры
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0), // Закругление верхних углов
      ),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return PopScope(
          canPop: !isLoading,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: AppConstants.mediumPadding,
              right: AppConstants.mediumPadding,
              top: AppConstants.mediumPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Введите ваш email',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Почта',
                    hintText: 'example@mail.com',
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.whiteSecondary,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Введите корректный email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ButtonWidget(
                  onPressed: () async {
                    if (_emailController.text.isNotEmpty && onTap != null) {
                      setState(() => isLoading = true);
                      await onTap(_emailController.text.trim());
                      setState(() => isLoading = false);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  isLoading: isLoading,
                  text: 'Отправить',
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      });
    },
  );
}
