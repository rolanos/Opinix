import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/api_exception.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';
import 'package:statistika_mobile/features/authorization/domain/model/user.dart';

import '../../../../core/utils/dio_client.dart';

import '../../../../core/utils/extensions.dart';
import '../dto/login_message.dart';

class AuthorizationRepository {
  Future<Either<ApiException, LoginMessage>> login(
      String email, String password) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.post(
        ApiRoutes.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      final data = result.data as Map<String, dynamic>;

      final loginResult = LoginMessage.fromJson(data);

      return Either.right(loginResult);
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, LoginMessage>> register(
    String email,
    String password,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.post(
        ApiRoutes.register,
        data: {
          "email": email,
          "password": password,
        },
      );

      final data = result.data as Map<String, dynamic>;

      final loginResult = LoginMessage.fromJson(data);

      return Either.right(loginResult);
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, User>> confirmEmail(
    String email,
    String code,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.post(
        ApiRoutes.confirmEmail,
        data: {
          "email": email,
          "token": code,
        },
      );

      switch (result.statusCode) {
        case HttpStatus.badRequest:
          return Either.left(ApiException(AppConstants.defaultError));
        case HttpStatus.badGateway:
          return Either.left(ApiException(AppConstants.defaultError));
        default:
      }

      final data = result.data as Map<String, dynamic>;

      if (data.containsKey('accessToken') && data['accessToken'] is String) {
        await SharedPreferencesManager.setAccessToken(data['accessToken']);
      }
      if (data.containsKey('refreshToken') && data['refreshToken'] is String) {
        await SharedPreferencesManager.setRefreshToken(data['refreshToken']);
      }

      if (data.containsKey('user')) {
        final user = User.fromJson(data['user']);

        await SharedPreferencesManager.setUserId(user.id);

        return Either.right(user);
      } else {
        return Either.left(ApiException(AppConstants.defaultError));
      }
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, Unit>> refreshToken() async {
    try {
      final dio = DioClient.dio;
      final result = await dio.post(
        ApiRoutes.refreshToken,
        data: {
          "refreshToken": await SharedPreferencesManager.getRefreshToken(),
          "userId": await SharedPreferencesManager.getUserId(),
        },
      );

      final data = result.data as Map<String, dynamic>;

      if (data.containsKey('accessToken') && data['accessToken'] is String) {
        await SharedPreferencesManager.setAccessToken(data['accessToken']);
      }
      if (data.containsKey('refreshToken') && data['refreshToken'] is String) {
        await SharedPreferencesManager.setRefreshToken(data['refreshToken']);
      }

      return Either.right(unit);
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, bool>> checkModerator() async {
    try {
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.checkModerate,
        queryParameters: {
          'userId': await SharedPreferencesManager.getUserId(),
        },
      );
      return Either.right(result.data as bool);
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, Unit>> logout() async {
    try {
      final dio = DioClient.dio;
      await dio.post(ApiRoutes.logout);
      return Either.right(unit);
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }
}
