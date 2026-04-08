import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/utils.dart';
import 'package:statistika_mobile/features/form/data/model/create_form_request.dart';
import 'package:statistika_mobile/features/form/domain/model/form.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/api_exception.dart';
import '../../../../core/utils/dio_client.dart';
import '../../../../core/utils/shared_preferences_manager.dart';

class FormRepository {
  Future<Either<Exception, List<Form>>> getAllForms() async {
    try {
      final list = <Form>[];
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.forms,
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      final data = result.data as List;
      await for (final element in Stream.fromIterable(data)) {
        list.add(Form.fromJson(element));
      }
      return Either.right(list);
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }

  Future<Either<Exception, List<Form>>> getUserForms() async {
    try {
      final list = <Form>[];
      final dio = DioClient.dio;
      final userId = await SharedPreferencesManager.getUserId();
      final result = await dio.get(
        ApiRoutes.formsByUserId,
        queryParameters: {"userId": userId},
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      final data = result.data as List;
      await for (final element in Stream.fromIterable(data)) {
        list.add(Form.fromJson(element));
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

  Future<Either<Exception, Form>> getFormById(String id) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.formsByFormId,
        queryParameters: {'id': id},
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(Form.fromJson(result.data));
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<Exception, Form>> createForm(
    CreateFormRequest request,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.post(
        ApiRoutes.forms,
        data: request.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(Form.fromJson(result.data));
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }
}
