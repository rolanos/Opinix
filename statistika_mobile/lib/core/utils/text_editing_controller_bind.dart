import 'dart:async';

import 'package:flutter/widgets.dart';

class TextEditingControllerBindList<T> {
  final List<TextEditingControllerBind<T>> list = [];

  //Save add
  void add(
    String id,
    T value, {
    String? initialValue,
    Function(T, String)? onChanged,
  }) {
    if (!contains(id)) {
      var newController = TextEditingControllerBind<T>(
        id: id,
        controller: TextEditingController(text: initialValue),
        value: value,
        onChanged: (v, t) {
          if (onChanged != null) {
            onChanged(v, t);
          }
        },
      );
      list.add(newController);
    }
  }

  TextEditingControllerBind? find(String id) {
    final elem = list.where((elem) => elem.id == id);
    if (elem.isNotEmpty) {
      return elem.first;
    }
    return null;
  }

  bool contains(String id) {
    final res = find(id);
    if (res != null) {
      return true;
    }
    return false;
  }

  void close() {
    for (var element in list) {
      element.close();
    }
  }
}

class TextEditingControllerBind<T> {
  TextEditingControllerBind({
    required this.id,
    required this.controller,
    required this.value,
    this.onChanged,
  }) {
    controller.addListener(_onTextChanged);
  }

  final String id;
  final TextEditingController controller;
  final T value;

  final Function(T, String)? onChanged;

  Timer? _timer;

  void close() => controller.dispose();

  void _onTextChanged() {
    // Отменяем предыдущий таймер, если он был
    _timer?.cancel();

    // Запускаем новый таймер на 3 секунды
    _timer = Timer(const Duration(milliseconds: 1500), () {
      // Действие, которое выполнится через 3 секунды после последнего изменения
      if (onChanged != null) {
        onChanged!(value, controller.text);
      }
    });
  }
}
