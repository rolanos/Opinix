import 'dart:async';

import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/input_widget.dart';
import 'package:statistika_mobile/features/form/domain/model/available_answer.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

import '../../constants/theme.dart';
import '../../utils/text_editing_controller_bind.dart';

class SingleChoiseCreateWidget extends StatefulWidget {
  const SingleChoiseCreateWidget({
    super.key,
    required this.question,
    this.onDeleteQuestion,
    this.onAddAnswer,
    this.onUpdateTitle,
    this.onDeleteAvailableAnswer,
    this.onUpdateAvailableAnswer,
    this.updateDuration,
  });

  final Question question;

  final Duration? updateDuration;

  final FutureOr<void> Function(Question)? onDeleteQuestion;

  final FutureOr<void> Function()? onAddAnswer;

  final FutureOr<void> Function(String)? onUpdateTitle;

  final FutureOr<void> Function(AvailableAnswer)? onDeleteAvailableAnswer;

  final FutureOr<void> Function(AvailableAnswer, String)?
      onUpdateAvailableAnswer;

  final String placeHolderSymbol = '•';

  @override
  State<SingleChoiseCreateWidget> createState() =>
      _SingleChoiseCreateWidgetState();
}

class _SingleChoiseCreateWidgetState extends State<SingleChoiseCreateWidget> {
  final titleController = TextEditingController();

  Timer? _debounceTimer; // Таймер для задержки

  late final TextEditingControllerBindList<AvailableAnswer>
      availableControllers;
  @override
  void initState() {
    super.initState();
    availableControllers = TextEditingControllerBindList<AvailableAnswer>();

    if (widget.question.title.isNotEmpty) {
      titleController.text = widget.question.title;
    }
    titleController.addListener(_onTextChanged);
    if (widget.question.availableAnswers.isNotEmpty) {
      for (var available in widget.question.availableAnswers) {
        availableControllers.add(
          available.id,
          available,
          initialValue: available.text,
          onChanged: (v, s) {
            if (widget.onUpdateAvailableAnswer != null) {
              widget.onUpdateAvailableAnswer!(v, s);
            }
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: AppTheme.shadow,
        borderRadius: BorderRadius.circular(AppConstants.mediumPadding),
      ),
      child: Builder(builder: (context) {
        for (var available in widget.question.availableAnswers) {
          availableControllers.add(
            available.id,
            available,
            initialValue: available.text,
            onChanged: (v, s) {
              if (widget.onUpdateAvailableAnswer != null) {
                widget.onUpdateAvailableAnswer!(v, s);
              }
            },
          );
        }
        return Column(
          spacing: AppConstants.smallPadding,
          children: [
            Row(
              children: [
                Flexible(
                  child: InputWidget(
                    controller: titleController,
                    hintText: 'Текст вопроса',
                    textStyle: context.textTheme.bodyLarge,
                  ),
                ),
                if (widget.onDeleteQuestion != null)
                  IconButton(
                    onPressed: () {
                      if (widget.onDeleteQuestion != null) {
                        widget.onDeleteQuestion!(widget.question);
                      }
                    },
                    icon: const Icon(Icons.delete),
                  ),
              ],
            ),
            const Divider(
              height: 0,
              thickness: 2,
            ),
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.question.availableAnswers.length,
              onReorder: (oldIndex, newIndex) {},
              itemBuilder: (context, index) => Column(
                key: ValueKey(widget.question.availableAnswers[index].id),
                children: [
                  ListTile(
                    leading: Text(
                      widget.placeHolderSymbol,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    minLeadingWidth: AppConstants.mediumPadding,
                    horizontalTitleGap: 0,
                    title: InputWidget(
                      controller: availableControllers
                              .find(widget.question.availableAnswers[index].id)
                              ?.controller ??
                          TextEditingController(),
                      hintText: 'Текст вопроса',
                    ),
                    contentPadding: EdgeInsets.zero,
                    trailing: IconButton(
                      onPressed: () {
                        if (widget.onDeleteAvailableAnswer != null) {
                          widget.onDeleteAvailableAnswer!(
                            widget.question.availableAnswers[index],
                          );
                        }
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.mediumPadding,
                    ),
                    child: Divider(height: 0),
                  ),
                ],
              ),
            ),
            Material(
              child: ListTile(
                minLeadingWidth: AppConstants.mediumPadding,
                horizontalTitleGap: AppConstants.smallPadding,
                leading: const Icon(
                  Icons.add,
                  color: AppColors.blueDark,
                ),
                onTap: widget.onAddAnswer,
                title: Text(
                  'Создать ответ...',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        );
      }),
    );
  }

  void _onTextChanged() {
    // Отменяем предыдущий таймер, если он был
    _debounceTimer?.cancel();

    // Запускаем новый таймер на 3 секунды
    _debounceTimer = Timer(widget.updateDuration ?? Duration.zero, () {
      // Действие, которое выполнится через 3 секунды после последнего изменения
      if (widget.onUpdateTitle != null) {
        widget.onUpdateTitle!(titleController.text);
      }
    });
  }
}
