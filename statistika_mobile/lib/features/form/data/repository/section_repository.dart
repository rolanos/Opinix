import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/form/domain/model/section.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/api_exception.dart';
import '../../../../core/utils/dio_client.dart';
import '../../../../core/utils/shared_preferences_manager.dart';

class SectionRepository {
  Future<Either<Exception, List<Section>>> getSections(String formId) async {
    try {
      final list = <Section>[];
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.sections,
        queryParameters: {'formId': formId},
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      final data = result.data as List;
      await for (final element in Stream.fromIterable(data)) {
        list.add(Section.fromJson(element));
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
}
