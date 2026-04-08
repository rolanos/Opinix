import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/model/classifier/classifier.dart';

import '../utils/dio_client.dart';
import '../utils/shared_preferences_manager.dart';

class ClassifierRepository {
  Future<Either<Exception, List<Classifier>>> getQuestionTypes() async {
    try {
      final list = <Classifier>[];
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.questionTypes,
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      final data = result.data as List;
      await for (final element in Stream.fromIterable(data)) {
        list.add(Classifier.fromJson(element));
      }
      return Either.right(list);
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }

  Future<Either<Exception, List<Classifier>>> getSurveyTypes() async {
    try {
      final list = <Classifier>[];
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.surveyTypes,
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      final data = result.data as List;
      await for (final element in Stream.fromIterable(data)) {
        list.add(Classifier.fromJson(element));
      }
      return Either.right(list);
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }

  Future<Either<Exception, List<Classifier>>> getSurveyRoles() async {
    try {
      final list = <Classifier>[];
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.surveyRoles,
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      final data = result.data as List;
      await for (final element in Stream.fromIterable(data)) {
        list.add(Classifier.fromJson(element));
      }
      return Either.right(list);
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }
}
