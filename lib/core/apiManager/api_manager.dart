import 'package:dio/dio.dart';
import '../handleErrors/result_pattern.dart';
import 'dio_client.dart';

class ApiService {
  static Future<dynamic> request({
    required String endpoint,
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (DioClient.dio == null) {
        try {
          await DioClient.init();
        } catch (e) {
          return Result.failure('Network client not initialized: $e');
        }
      }

      final response = await DioClient.dio!.request(
        endpoint,
        data: data,
        queryParameters: queryParameters,

        options: Options(method: method, headers: headers),
      );

      final res = response.data;

      // لو الرجوع success = false
      if (res is Map && res["success"] == false) {
        final error = (res["errors"] != null
            ? res["errors"].values.first.first ?? res["message"]
            : "Unknown error");

        return Result.failure(error);
      }

      return res;
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map) {
        final res = e.response!.data;

        // Handle Django non_field_errors (e.g. "Invalid credentials.")
        if (res["non_field_errors"] != null && res["non_field_errors"] is List && res["non_field_errors"].isNotEmpty) {
          return Result.failure(res["non_field_errors"].first.toString());
        }

        // Handle structured errors map
        final error = (res["errors"] != null && res["errors"] is Map && res["errors"].isNotEmpty)
            ? (res["errors"].values.first is List ? res["errors"].values.first.first : res["errors"].values.first)
            : (res["message"] ?? res["detail"] ?? e.message);
        return Result.failure(error);
      }
      return Result.failure(e.message ?? "Unknown network error");
    }
  }

  static Future<dynamic> requestWithFormData({
    required String endpoint,
    String method = "POST",
    Map<String, dynamic>? queryParameters,
    required FormData data,
    Map<String, dynamic>? headers,
    Function(int, int)? onSendProgress, // للتحميل progress
  }) async {
    try {
      if (DioClient.dio == null) {
        try {
          await DioClient.init();
        } catch (e) {
          return Result.failure('Network client not initialized: $e');
        }
      }

      final response = await DioClient.dio!.request(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          headers: {'Content-Type': 'multipart/form-data', ...?headers},
        ),
        onSendProgress: onSendProgress,
      );

      final res = response.data;

      // لو الرجوع success = false
      if (res is Map && res["success"] == false) {
        String error = (res["errors"] is Map && res["errors"].isNotEmpty)
            ? res["errors"].values.first
            : res["message"] ?? "Unknown error";

        return Result.failure(error);
      }

      return res;
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map) {
        final res = e.response!.data;

        // Handle Django non_field_errors
        if (res["non_field_errors"] != null && res["non_field_errors"] is List && res["non_field_errors"].isNotEmpty) {
          return Result.failure(res["non_field_errors"].first.toString());
        }

        // Handle structured errors map
        final error = (res["errors"] != null && res["errors"] is Map && res["errors"].isNotEmpty)
            ? (res["errors"].values.first is List ? res["errors"].values.first.first : res["errors"].values.first)
            : (res["message"] ?? res["detail"] ?? e.message);
        return Result.failure(error);
      }
      return Result.failure(e.message ?? "Unknown network error");
    }
  }

  // ✅ NEW: helper method لرفع ملف
  static Future<MultipartFile> createMultipartFile({
    required String filePath,
    String? filename,
  }) async {
    return await MultipartFile.fromFile(filePath, filename: filename);
  }
}
