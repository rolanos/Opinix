import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';
import 'package:statistika_mobile/features/survey/domain/model/survey_configuration/survey_configuration.dart';
import 'package:statistika_mobile/features/survey/domain/model/survey_configuration_update/survey_configuration_update_request.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/utils/dio_client.dart';

class SurveyConfigurationRepository {
  Future<Either<Exception, SurveyConfiguration>> getSurveyConfiguration(
    String surveyId,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.surveyConfiguration,
        queryParameters: {'surveyId': surveyId},
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(SurveyConfiguration.fromJson(result.data));
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }

  Future<Either<Exception, SurveyConfiguration>> updateSurveyConfiguration(
    SurveyConfigurationUpdateRequest request,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.patch(
        ApiRoutes.surveyConfiguration,
        data: request.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(SurveyConfiguration.fromJson(result.data));
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }
}
