import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';
import 'package:statistika_mobile/features/authorization/data/repository/authorization_repository.dart';

class DioClient {
  static Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )
    ..interceptors.add(CookieManager(cookie))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final tokenMap = await SharedPreferencesManager.getTokenAsMap();
          var newHeaders = options.headers
            ..addAll(
              tokenMap,
            );
          options.headers = newHeaders;
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            try {
              final result = await AuthorizationRepository().refreshToken();
              if (result.isLeft()) {
                return handler.reject(error);
              }
              result.match(
                (e) {
                  return;
                },
                (s) async {
                  error.requestOptions.headers =
                      await SharedPreferencesManager.getTokenAsMap();
                },
              );
              final opts = Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              );
              final cloneReq = await dio.request(
                error.requestOptions.path,
                options: opts,
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );

              return handler.resolve(cloneReq);
            } catch (e) {
              log(e.toString());
            }
          } else {
            return handler.reject(error);
          }
        },
      ),
    );

  static final CookieJar cookie = CookieJar();

  DioClient();
}
