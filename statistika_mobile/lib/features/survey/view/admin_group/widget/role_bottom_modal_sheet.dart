import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/model/classifier/classifier.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/button_widget.dart';
import 'package:statistika_mobile/features/home/cubit/survey_roles_cubit.dart';

Future<void> showRoleBottomSheet(
  BuildContext context, {
  FutureOr<void> Function(Classifier)? onTap,
}) async {
  Classifier? role;

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
                  'Редактирование прав доступа',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<SurveyRolesCubit, SurveyRolesState>(
                  builder: (context, state) {
                    return DropdownButton<Classifier>(
                      isExpanded: true,
                      value: role,
                      hint: const Text(
                        'Роль',
                      ),
                      underline: const SizedBox(),
                      style: context.textTheme.bodyMedium,
                      items: state is SurveyRolesInitial
                          ? List.generate(
                              state.types.length,
                              (i) => DropdownMenuItem(
                                value: state.types[i],
                                child: Row(
                                  children: [Text(state.types[i].name)],
                                ),
                              ),
                            )
                          : [],
                      onChanged: (value) => setState(
                        () => role = value,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ButtonWidget(
                  onPressed: () async {
                    if (role != null && onTap != null) {
                      setState(() => isLoading = true);
                      await onTap(role!);
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
