import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';
import 'package:statistika_mobile/features/survey/domain/model/survey/survey.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/utils/dio_client.dart';

class SurveyRepository {
  Future<Either<Exception, List<Survey>>> getSurveys() async {
    try {
      final list = <Survey>[];
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.surveys,
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      final data = result.data as List;
      await for (final element in Stream.fromIterable(data)) {
        list.add(Survey.fromJson(element));
      }
      return Either.right(list);
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }
}
