import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/utils/utils.dart';

Future<bool> showCustomDialog(
  BuildContext context,
  String title,
  String description,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        title,
        style: context.textTheme.titleMedium,
      ),
      content: Text(
        description,
        style: context.textTheme.bodyMedium,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(
            context,
            false,
          ),
          child: Text(
            'Нет',
            style: context.textTheme.titleSmall,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(
            context,
            true,
          ),
          child: Text(
            'Да',
            style: context.textTheme.titleSmall,
          ),
        ),
      ],
    ),
  );

  return result ?? false;
}
