import 'single_choise_create.dart';

class MultipleChoiseCreateWidget extends SingleChoiseCreateWidget {
  const MultipleChoiseCreateWidget({
    super.key,
    required super.question,
    super.onDeleteQuestion,
    super.onAddAnswer,
    super.onUpdateTitle,
    super.updateDuration,
    super.onDeleteAvailableAnswer,
    super.onUpdateAvailableAnswer,
  });

  @override
  String get placeHolderSymbol => '■';
}
