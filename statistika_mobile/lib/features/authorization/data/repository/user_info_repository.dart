import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/features/authorization/domain/model/user_info.dart';

import '../../../../core/utils/dio_client.dart';
import '../dto/update_user_info_request.dart';

class UserInfoRepository {
  Future<Either<Exception, UserInfo>> updateUserInfo(
    UpdateUserInfoRequest request,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.put(
        ApiRoutes.userInfo,
        data: request.toJson(),
      );

      final data = result.data as Map<String, dynamic>;

      return Either.right(UserInfo.fromJson(data));
    } on DioException catch (e) {
      log(e.toString());
      return Either.left(e);
    } catch (e) {
      log(e.toString());
      return Either.left(Exception("Что-то пошло не так, попробуйте позже"));
    }
  }

  Future<Either<Exception, void>> updatePhoto(
    String userProfileId,
    XFile file,
  ) async {
    try {
      final dio = DioClient.dio;

      MultipartFile multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: file.name,
      );

      var formData = FormData.fromMap(
        {
          'ElementId': userProfileId,
          'FormFile': multipartFile,
        },
      );
      final result = await dio.post(
        ApiRoutes.files,
        data: formData,
      );

      void _;
      return Either.right(_);
    } on DioException catch (e) {
      log(e.toString());
      return Either.left(e);
    } catch (e) {
      log(e.toString());
      return Either.left(Exception("Что-то пошло не так, попробуйте позже"));
    }
  }
}
