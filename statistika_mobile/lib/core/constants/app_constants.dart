import 'dart:ui';

abstract class AppConstants {
  static const miniPadding = 4.0;
  static const smallPadding = 8.0;
  static const mediumPadding = 16.0;
  static const largePadding = 24.0;

  static const apiErrorFieldName = 'error';
  static const apiErrorFieldNameSecond = 'title';
  static const defaultError = 'Что-то пошло не так, попробуйте позже';

  static const animationChangeSizeDuration = Duration(milliseconds: 250);
}

abstract class AppColors {
  static const gray = Color(0xFF737373);
  static const grayLight = Color(0x4B353635);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF3a3a3a);

  static const whiteSecondary = Color(0xFFADAEBC);

  static const divider = Color.fromARGB(158, 214, 214, 219);

  static const border = Color(0xFF3a3a3a);

  static const blueDark = Color.fromARGB(178, 41, 120, 255);
  static const blue = Color(0xFF2979FF);

  static const red = Color(0xFFEF4444);

  static const shadow = Color(0xFFD0D0D0);

  static const container = Color(0xFF3a3a3a);
}

abstract class HeroConstants {
  static const questionContainer = 'questionContainer';
}
