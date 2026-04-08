import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/model/analitical/analitical_complex.dart';

import '../constants/routes.dart';
import '../dto/analitic_request/analitic_request.dart';
import '../utils/dio_client.dart';
import '../utils/shared_preferences_manager.dart';

class AnaliticalRepository {
  Future<Either<Exception, AnaliticComplexResult>> getAnalitic(
    String questionId, {
    AnaliticRequest? analiticRequest,
  }) async {
    try {
      final dio = DioClient.dio;
      var queryParaameters = <String, dynamic>{
        "questionId": questionId,
      };
      if (analiticRequest != null) {
        queryParaameters.addAll(analiticRequest.toJson());
      }

      final result = await dio.get(
        ApiRoutes.analitical,
        queryParameters: queryParaameters,
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(AnaliticComplexResult.fromJson(result.data));
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }
}
