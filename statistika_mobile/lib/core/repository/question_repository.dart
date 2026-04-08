import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/dto/create_question/create_question_request.dart';
import 'package:statistika_mobile/core/dto/create_question/create_question_response.dart';
import 'package:statistika_mobile/core/utils/api_exception.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/form/data/model/update_question_request.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

import '../constants/app_constants.dart';
import '../utils/dio_client.dart';
import '../utils/shared_preferences_manager.dart';

class QuestionRepository {
  Future<Either<ApiException, Question>> getNextGeneralQuestion() async {
    try {
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.nextGeneralQuestion,
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      if ((result.statusCode ?? 400) < 400 && result.data is String) {
        final message = result.data as String;
        return Either.left(
          ApiException(message),
        );
      }
      return Either.right(Question.fromJson(result.data));
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, List<Question>>> getMyGeneralQuestions() async {
    try {
      final list = <Question>[];
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.myGeneralQuestion,
        queryParameters: {
          'userId': await SharedPreferencesManager.getUserId(),
        },
      );
      final data = result.data as List;
      await for (final element in Stream.fromIterable(data)) {
        list.add(Question.fromJson(element));
      }
      return Either.right(list);
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, List<Question>>>
      getHistoryGeneralQuestions() async {
    try {
      final list = <Question>[];
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.historyGeneralQuestion,
        queryParameters: {
          'userId': await SharedPreferencesManager.getUserId(),
        },
      );
      final data = result.data as List;
      await for (final element in Stream.fromIterable(data)) {
        list.add(Question.fromJson(element));
      }
      return Either.right(list);
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, CreateQuestionResponse>> createQuestion(
    CreateQuestionRequest createRequest,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.post(
        ApiRoutes.questions,
        data: createRequest.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(CreateQuestionResponse.fromJson(result.data));
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, Question>> updateQuestion(
    UpdateQuestionRequest updateRequest,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.patch(
        ApiRoutes.questions,
        data: updateRequest.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(Question.fromJson(result.data));
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, Question>> deleteQuestion(String id) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.delete(
        ApiRoutes.questions,
        data: {'id': id},
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(Question.fromJson(result.data));
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, Question>> getQuestionById(String id) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.questions,
        queryParameters: {'id': id},
      );
      return Either.right(Question.fromJson(result.data));
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, Question>> nextToModerateQuestion() async {
    try {
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.nextToModerateGeneralQuestion,
      );
      return Either.right(Question.fromJson(result.data));
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, Question>> confirmModerate(String questionId, bool moderated) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.post(
        ApiRoutes.confirmModerateGeneralQuestion,
        data: {
          'QuestionId': questionId,
          'IsModerated': moderated,
        },
      );
      return Either.right(Question.fromJson(result.data));
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }
}
