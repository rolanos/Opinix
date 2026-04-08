import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/dto/create_admin_group/create_admin_group.dart';
import 'package:statistika_mobile/core/dto/update_admin_group/update_admin_group.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/dto/delete_admin_group/delete_admin_group.dart';
import '../../../../core/utils/dio_client.dart';
import '../../../../core/utils/shared_preferences_manager.dart';
import '../../domain/model/admin_group/admin_group.dart';

class AdminGroupRepository {
  Future<Either<Exception, List<AdminGroup>>> getAdminGroups(
    String surveyId,
  ) async {
    try {
      final adminGroup = <AdminGroup>[];
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.adminGroup,
        queryParameters: {'surveyId': surveyId},
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      final data = result.data as List;
      await for (final item in Stream.fromIterable(data)) {
        adminGroup.add(AdminGroup.fromJson(item));
      }
      return Either.right(adminGroup);
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }

  Future<Either<Exception, AdminGroup>> addAdminGroup(
    CreateAdminGroup request,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.post(
        ApiRoutes.adminGroup,
        data: request.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );

      return Either.right(AdminGroup.fromJson(result.data));
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }

  Future<Either<Exception, AdminGroup>> updateAdminGroup(
    UpdateAdminGroup request,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.patch(
        ApiRoutes.adminGroup,
        data: request.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );

      return Either.right(AdminGroup.fromJson(result.data));
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }

  Future<Either<Exception, AdminGroup>> deleteAdminGroup(
    DeleteAdminGroup request,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.delete(
        ApiRoutes.adminGroup,
        data: request.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );

      return Either.right(AdminGroup.fromJson(result.data));
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }
}
