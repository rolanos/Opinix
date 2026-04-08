import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/features/authorization/domain/model/user.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/utils/dio_client.dart';

class UserRepository {
  Future<Either<Exception, User>> getUserById(String id) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.users,
        queryParameters: {'id': id},
      );

      return Either.right(User.fromJson(result.data));
    } on DioException catch (e) {
      log(e.toString());
      return Either.left(e);
    } catch (e) {
      log(e.toString());
      return Either.left(Exception("Что-то пошло не так, попробуйте позже"));
    }
  }
}
