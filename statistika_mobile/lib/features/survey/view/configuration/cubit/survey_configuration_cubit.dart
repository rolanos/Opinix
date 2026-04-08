import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/survey/data/repository/survey_configuration_repository.dart';
import 'package:statistika_mobile/features/survey/domain/model/survey_configuration/survey_configuration.dart';

import '../../../domain/model/survey_configuration_update/survey_configuration_update_request.dart';

part 'survey_configuration_state.dart';

class SurveyConfigurationCubit extends Cubit<SurveyConfigurationState> {
  SurveyConfigurationCubit() : super(SurveyConfigurationEmpty());

  Future<void> init(String? surveyId) async {
    if (surveyId == null) {
      emit(
        SurveyConfigurationError(
          message: 'Что-то пошло не так, попробуйте позже',
        ),
      );
      return;
    }

    emit(SurveyConfigurationLoading());

    final config =
        await SurveyConfigurationRepository().getSurveyConfiguration(surveyId);

    config.match(
      (e) => emit(
        SurveyConfigurationError(
          message: e.toString(),
        ),
      ),
      (c) => emit(SurveyConfigurationInitial(surveyConfiguration: c)),
    );
  }

  Future<void> update() async {
    var state = this.state;
    if (state is SurveyConfigurationInitial) {
      final config = await SurveyConfigurationRepository()
          .getSurveyConfiguration(state.surveyConfiguration.surveyId);

      config.match(
        (e) => emit(
          SurveyConfigurationError(
            message: e.toString(),
          ),
        ),
        (c) => emit(SurveyConfigurationInitial(surveyConfiguration: c)),
      );
    }
    state = this.state;
    if (state is SurveyConfigurationError) {
      await init(state.surveyId);
    }
  }

  Future<void> updateConfiguration({
    bool? isAnonymous,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    var state = this.state;
    if (state is SurveyConfigurationInitial) {
      final request = SurveyConfigurationUpdateRequest(
        id: state.surveyConfiguration.id,
        startDate: startDate,
        endDate: endDate,
        isAnonymous: isAnonymous ?? state.surveyConfiguration.isAnonymous,
      );
      emit(
        SurveyConfigurationUpdateLoading(
          surveyConfiguration: state.surveyConfiguration,
        ),
      );
      final config = await SurveyConfigurationRepository()
          .updateSurveyConfiguration(request);

      config.match(
        (e) => emit(
          SurveyConfigurationError(
            message: e.toString(),
          ),
        ),
        (c) => emit(SurveyConfigurationInitial(surveyConfiguration: c)),
      );
    }
    state = this.state;
    if (state is SurveyConfigurationError) {
      await init(state.surveyId);
    }
  }
}
