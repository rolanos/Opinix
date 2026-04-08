import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/model/classifier/classifier.dart';

import '../../../core/repository/classifier_repository.dart';

class SurveyTypesCubit extends Cubit<SurveyTypesState> {
  SurveyTypesCubit() : super(SurveyTypesEmpty());

  Future<void> update() async {
    final result = await ClassifierRepository().getSurveyTypes();

    result.match(
      (e) => emit(SurveyTypesError(message: e.toString())),
      (q) => emit(SurveyTypesInitial(types: q)),
    );
  }
}

@immutable
sealed class SurveyTypesState {}

final class SurveyTypesEmpty extends SurveyTypesState {}

final class SurveyTypesLoading extends SurveyTypesState {}

final class SurveyTypesError extends SurveyTypesState {
  final String message;

  SurveyTypesError({required this.message});
}

final class SurveyTypesInitial extends SurveyTypesState {
  final List<Classifier> types;

  SurveyTypesInitial({required this.types});
}
