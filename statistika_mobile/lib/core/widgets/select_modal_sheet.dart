import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';

import '../model/named_type.dart';

Future<void> showSelectionModal<T extends NamedType>(
  BuildContext context,
  List<T> elements, {
  String? title,
  Function(T)? onTap,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (BuildContext sheetContext) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
        ),
        child: SelectModalSheetWidget<T>(
          title: title,
          list: elements,
          onTap: onTap,
        ),
      );
    },
  );
}

class SelectModalSheetWidget<T extends NamedType> extends StatelessWidget {
  const SelectModalSheetWidget({
    super.key,
    this.title,
    this.onTap,
    this.list = const [],
  });

  final String? title;

  final Function(T)? onTap;

  final List<T> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Make the column wrap its content
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title ?? 'Выберите значение',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Divider(height: 1),
        ListView.separated(
          shrinkWrap: true,
          itemCount: list.length,
          separatorBuilder: (context, index) => const Divider(
            height: 0,
          ),
          itemBuilder: (context, index) => Material(
            child: ListTile(
              onTap: () {
                if (onTap != null) {
                  onTap!(list[index]);
                }
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              title: Text(
                list[index].name,
                style: context.textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: AppConstants.mediumPadding,
        ),
      ],
    );
  }
}
