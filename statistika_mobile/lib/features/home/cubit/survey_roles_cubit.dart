import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/model/classifier/classifier.dart';

import '../../../core/repository/classifier_repository.dart';

class SurveyRolesCubit extends Cubit<SurveyRolesState> {
  SurveyRolesCubit() : super(SurveyRolesEmpty());

  Future<void> update() async {
    final result = await ClassifierRepository().getSurveyRoles();

    result.match(
      (e) => emit(SurveyRolesError(message: e.toString())),
      (q) => emit(SurveyRolesInitial(types: q)),
    );
  }
}

@immutable
sealed class SurveyRolesState {}

final class SurveyRolesEmpty extends SurveyRolesState {}

final class SurveyRolesLoading extends SurveyRolesState {}

final class SurveyRolesError extends SurveyRolesState {
  final String message;

  SurveyRolesError({required this.message});
}

final class SurveyRolesInitial extends SurveyRolesState {
  final List<Classifier> types;

  SurveyRolesInitial({required this.types});
}
