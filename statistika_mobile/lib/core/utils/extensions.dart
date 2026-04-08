import 'dart:developer';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/utils/api_exception.dart';

import '../constants/app_constants.dart';

extension ThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ElevatedButtonThemeData get elevatedStyle =>
      Theme.of(this).elevatedButtonTheme;

  Size get mediaQuerySize => MediaQuery.of(this).size;

  String? getQueryValueOrNull(String name) {
    var params = GoRouterState.of(this).uri.queryParameters;
    if (params.containsKey(name)) {
      return params[name];
    }
    return null;
  }
}

extension StringNullableExtension on String? {
  String? get asDate => DateTime.tryParse(this ?? '').toString();
}

extension DateTimeExtension on DateTime {
  String toFormattedString() {
    var result = '';
    if (day > 9) {
      result += '$day.';
    } else {
      result += '0$day.';
    }
    if (month > 9) {
      result += '$month.';
    } else {
      result += '0$month.';
    }
    result += year.toString();
    return result;
  }
}

extension IntegerListExtension on List<int> {
  int getMax() {
    if (isNotEmpty) {
      var maxValue = first;
      for (var value in this) {
        maxValue = math.max(maxValue, value);
      }
      return maxValue;
    } else {
      return 0;
    }
  }
}

extension DioExceptionExtension on DioException {
  ApiException get toParsed {
    log(toString());
    var error = AppConstants.defaultError;
    if (response?.data is Map) {
      final data = response?.data as Map<String, dynamic>?;
      if (data != null && data.containsKey(AppConstants.apiErrorFieldName)) {
        error = data[AppConstants.apiErrorFieldName];
      } else if (data != null &&
          data.containsKey(AppConstants.apiErrorFieldNameSecond)) {
        error = data[AppConstants.apiErrorFieldNameSecond];
      }
    }
    return ApiException(error);
  }
}

extension ExceptionExtension on Exception {
  ApiException get toParsed {
    log(toString());
    return ApiException(AppConstants.defaultError);
  }
}
