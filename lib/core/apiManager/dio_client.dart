import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fodwa/core/session/session_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fodwa/core/config/env_config.dart';

class DioClient {
  static PersistCookieJar? cookieJar;
  static Dio? dio;

  // لازم تنادي init() أول ما الاب يفتح
  static Future<void> init() async {
    Directory dir = await getApplicationDocumentsDirectory();

    cookieJar = PersistCookieJar(storage: FileStorage("${dir.path}/cookies"));

    dio =
        Dio(
            BaseOptions(
              baseUrl: EnvConfig.baseUrl,
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
              sendTimeout: const Duration(seconds: 30),
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
              },
            ),
          )
          ..interceptors.addAll([
            LogInterceptor(responseBody: true, requestBody: true),
            CookieManager(cookieJar!),
            InterceptorsWrapper(
              onRequest: (options, handler) async {
                final token = await SessionManager.getToken();
                if (token != null && token.isNotEmpty) {
                  options.headers['Authorization'] = 'Bearer $token';
                }
                return handler.next(options);
              },
            ),
          ]);

    (dio!.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      return client;
    };
  }
}
