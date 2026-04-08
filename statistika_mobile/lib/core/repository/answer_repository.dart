import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/dto/create_answer/create_answer_request.dart';
import 'package:statistika_mobile/core/dto/create_answer/create_answers_to_form_request.dart';

import '../constants/routes.dart';
import '../utils/dio_client.dart';
import '../utils/shared_preferences_manager.dart';

class AnswerRepository {
  Future<Either<Exception, String>> sendFormAnswers(
    CreateAnswersToFormRequest request,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.post(
        ApiRoutes.answersForForm,
        data: request.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(result.data.toString());
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }

  Future<Either<Exception, String>> sendAnswer(
    CreateAnswerRequest request,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.post(
        ApiRoutes.answers,
        data: request.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(result.data.toString());
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }
}
