import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/model/classifier/classifier.dart';

import '../../../core/repository/classifier_repository.dart';

class QuestionTypesCubit extends Cubit<QuestionTypesState> {
  QuestionTypesCubit() : super(QuestionTypesEmpty());

  Future<void> update() async {
    final result = await ClassifierRepository().getSurveyRoles();

    result.match(
      (e) => emit(QuestionTypesError(message: e.toString())),
      (q) => emit(QuestionTypesInitial(types: q)),
    );
  }
}

@immutable
sealed class QuestionTypesState {}

final class QuestionTypesEmpty extends QuestionTypesState {}

final class QuestionTypesLoading extends QuestionTypesState {}

final class QuestionTypesError extends QuestionTypesState {
  final String message;

  QuestionTypesError({required this.message});
}

final class QuestionTypesInitial extends QuestionTypesState {
  final List<Classifier> types;

  QuestionTypesInitial({required this.types});
}
