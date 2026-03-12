import 'package:dio/dio.dart';
import 'dart:io';
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
      return Result.failure(_handleDioExceptionError(e));
    } catch (e) {
      return Result.failure('Unexpected error occurred: $e');
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
      return Result.failure(_handleDioExceptionError(e));
    } catch (e) {
      return Result.failure('Unexpected error occurred: $e');
    }
  }

  // ✅ NEW: helper method لرفع ملف
  static Future<MultipartFile> createMultipartFile({
    required String filePath,
    String? filename,
  }) async {
    return await MultipartFile.fromFile(filePath, filename: filename);
  }

  static String _handleDioExceptionError(DioException e) {
    if (e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.sendTimeout || e.type == DioExceptionType.connectionTimeout) {
      return "Server is taking too long to respond. Please try again.";
    }
    
    if (e.type == DioExceptionType.connectionError || e.error is SocketException) {
      final errorStr = e.error.toString();
      if (errorStr.contains('Connection reset by peer')) {
        return "Network connection lost. Please check your internet.";
      }
      return "No internet connection";
    }

    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final data = e.response!.data;

      // specifically handle 401 Unauthorized
      if (statusCode == 401) {
        return "Session expired or Unauthorized access. Please log in again.";
      }

      // Handle Map structures
      if (data is Map) {
        // Handle Django non_field_errors
        if (data["non_field_errors"] != null && data["non_field_errors"] is List && data["non_field_errors"].isNotEmpty) {
          return data["non_field_errors"].first.toString();
        }

        // Handle structured errors map
        if (data["errors"] != null && data["errors"] is Map && data["errors"].isNotEmpty) {
           final firstError = data["errors"].values.first;
           return (firstError is List ? firstError.first.toString() : firstError.toString());
        }

        return data["message"] ?? data["detail"] ?? e.message ?? "Unknown network error";
      }
      
      if (statusCode == 400) {
        return "Bad Request. Please check the input and try again.";
      }
    }
    
    return e.message ?? "Unknown network error";
  }
}
