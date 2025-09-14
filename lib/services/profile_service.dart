import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lubes_bazaar/models/user_model.dart';
import 'package:lubes_bazaar/services/api_endpoints.dart';

class UserService {
  static final String baseUrl = ApiEndpoints.user;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  /// 🔹 Update profile
  Future<UserModel?> updateProfile(UserModel user) async {
    try {
      // Secure storage se userId aur token read karo agar null/0 ho
      final storedToken = await storage.read(key: "auth_token");
      final storedUserId = await storage.read(key: "user_id");

      final token = user.token ?? storedToken;
      final userId = user.id != 0
          ? user.id
          : (storedUserId != null ? int.parse(storedUserId) : 0);

      if (token == null || userId == 0) {
        debugPrint("❌ Missing token or userId, cannot update profile");
        return null;
      }

      debugPrint(
        "➡️ Sending updateProfile request with userId=$userId & token=$token",
      );

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userdata": {
            "action": "updateUserProfile",
            "userId": userId,
            "token": token,
            "fname": user.fname,
            "lname": user.lname,
            "email": user.email,
            "phone": user.phone,
          },
        }),
      );

      debugPrint("⬅️ Response Status: ${response.statusCode}");
      debugPrint("⬅️ Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["type"] == true) {
          debugPrint("✅ Profile updated successfully");
          if (data["dataInfo"] != null) {
            return UserModel.fromJson(data["dataInfo"]);
          }
          return user; // fallback
        } else {
          debugPrint("⚠️ Server error: ${data["message"]}");
        }
      } else {
        debugPrint("❌ API error: Status ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ Exception in updateProfile: $e");
    }
    return null;
  }

  /// 🔹 Change password
  Future<bool> changePassword({
    int? userId,
    String? token,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      // ✅ Secure storage se read karo agar null/0 ho
      final storedToken = await storage.read(key: "auth_token");
      final storedUserId = await storage.read(key: "user_id");

      final finalToken = token ?? storedToken;
      final finalUserId = (userId != null && userId != 0)
          ? userId
          : (storedUserId != null ? int.parse(storedUserId) : 0);

      if (finalToken == null || finalUserId == 0) {
        debugPrint("❌ Missing token or userId, cannot change password");
        return false;
      }

      debugPrint(
        "➡️ Sending changePassword request for userId=$finalUserId & token=$finalToken",
      );

      final requestBody = {
        "userdata": {
          "action": "changePassword",
          "userId": finalUserId, // ✅ string me bhejna hai
          "token": finalToken,
          "old_password": oldPassword,
          "new_password": newPassword,
        },
      };

      debugPrint("📤 Request Body: ${jsonEncode(requestBody)}");

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      debugPrint("⬅️ Response Status: ${response.statusCode}");
      debugPrint("⬅️ Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final success = data["type"] == true;
        debugPrint(
          success
              ? "✅ Password changed successfully"
              : "❌ Failed to change password: ${data["message"]}",
        );
        return success;
      } else {
        debugPrint("❌ API error: Status ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ Exception in changePassword: $e");
    }
    return false;
  }

  /// 🔹 Fetch profile using saved token (app restart ke liye)
  Future<UserModel?> getProfile() async {
    try {
      final token = await storage.read(key: "auth_token");
      final userId = await storage.read(key: "user_id");

      if (token == null || userId == null) return null;

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userdata": {
            "action": "getUserInfo", // ✅ yaha change
            "userId": userId, // ✅ string bhejna
            "token": token,
          },
        }),
      );

      debugPrint("➡️ Fetch profile response status: ${response.statusCode}");
      debugPrint("➡️ Fetch profile response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["type"] == true && data["dataInfo"] != null) {
          return UserModel.fromJson(data["dataInfo"]);
        }
      }
    } catch (e) {
      debugPrint("❌ Error fetching profile: $e");
    }
    return null;
  }
}
