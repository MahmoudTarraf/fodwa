import 'package:fodwa/core/cahsing/get_storage_helper.dart';
import 'package:fodwa/core/cahsing/secure_storage.dart';
import 'package:fodwa/core/cahsing/app_keys.dart';
import 'package:flutter/foundation.dart';

class SessionManager {
  static Future<void> saveSession({
    required String token,
    required String userId,
  }) async {
    try {
      await SecureStorageHelper.write(AppKeys.authToken, token);
      await SecureStorageHelper.write(AppKeys.userId, userId);
      await GetStorageHelper.write(AppKeys.isLoggedIn, true);
    } catch (e) {
      // Log error but don't throw, let app continue if possible
      debugPrint('Error saving session: $e');
    }
  }

  static Future<void> clearSession() async {
    try {
      await SecureStorageHelper.delete(AppKeys.authToken);
      await SecureStorageHelper.delete(AppKeys.userId);
      await GetStorageHelper.remove(AppKeys.isLoggedIn);
    } catch (e) {
      debugPrint('Error clearing session: $e');
    }
  }

  static Future<bool> isLoggedIn() async {
    try {
      final token = await SecureStorageHelper.read(AppKeys.authToken);
      final userId = await SecureStorageHelper.read(AppKeys.userId);
      return token != null &&
          token.isNotEmpty &&
          userId != null &&
          userId.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getToken() async {
    return await SecureStorageHelper.read(AppKeys.authToken);
  }

  static Future<String?> getUserId() async {
    return await SecureStorageHelper.read(AppKeys.userId);
  }
}
