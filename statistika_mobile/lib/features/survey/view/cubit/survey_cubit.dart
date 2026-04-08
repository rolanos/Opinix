import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/survey/data/repository/survey_repository.dart';
import 'package:statistika_mobile/features/survey/domain/model/survey/survey.dart';

part 'survey_state.dart';

class SurveyCubit extends Cubit<SurveyState> {
  SurveyCubit() : super(SurveyLoading());

  Future<void> getSurveys() async {
    final result = await SurveyRepository().getSurveys();
    result.match(
      (e) => emit(SurveyError(message: e.toString())),
      (list) => emit(
        SurveyInitial(surveys: list),
      ),
    );
  }
}
