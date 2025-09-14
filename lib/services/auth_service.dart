// auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lubes_bazaar/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lubes_bazaar/services/api_endpoints.dart';

class AuthService {
  final String baseUrl = ApiEndpoints.user;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // ✅ REGISTER USER
  Future<UserModel?> registerUser({
    required String acType,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final bodyData = {
        "userdata": {
          "action": "registerUser",
          "ac_type": acType,
          "fname": firstName,
          "lname": lastName,
          "email": email,
          "password": password,
          "mobile_no": null,
        },
      };

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(bodyData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if ((data["status"] == 200 || data["status"] == "200") ||
            data["type"] == true) {
          if (data["data"] != null) {
            return UserModel.fromJson(data["data"]);
          } else {
            return UserModel(
              id: 0,
              fname: firstName,
              lname: lastName,
              email: email,
              token: null,
              phone: '',
            );
          }
        }
      }
      return null;
    } catch (e) {
      print("❌ Register error: $e");
      return null;
    }
  }

  // ✅ LOGIN USER
  Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final bodyData = {
        "userdata": {
          "action": "checkValidUser",
          "email": email,
          "password": password,
        },
      };

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(bodyData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if ((data["status"] == 200 || data["status"] == "200") &&
            data["type"] == true) {
          if (data["dataInfo"] != null) {
            final user = UserModel.fromJson(data["dataInfo"]);

            // ✅ Save token securely
            if (user.token != null && user.token!.isNotEmpty) {
              await storage.write(key: "auth_token", value: user.token);
              await storage.write(key: "user_id", value: user.id.toString());
            }

            return user;
          }
        }
      }
      return null;
    } catch (e) {
      print("❌ Login error: $e");
      return null;
    }
  }

  // ✅ LOGOUT USER
  Future<String?> logoutUser() async {
    String? message;
    try {
      final token = await storage.read(key: 'auth_token');
      final userIdStr = await storage.read(key: 'user_id');
      final userId = userIdStr != null ? int.tryParse(userIdStr) : null;

      if (userId == null || token == null) {
        return "❌ Logout failed: userId or token not found";
      }

      final body = {
        "userdata": {"action": "logout", "userId": userId, "token": token},
      };

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        message = data["message"];
      } else {
        message = "⚠️ API returned status ${response.statusCode}";
      }
    } catch (e) {
      message = "❌ Exception during logout: $e";
    } finally {
      await storage.delete(key: 'auth_token');
      await storage.delete(key: 'user_id');
    }

    return message;
  }

  // ✅ Get token securely
  Future<String?> getToken() async {
    final token = await storage.read(key: "auth_token");
    return token;
  }

  // ✅ Check if logged in
  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: "auth_token");
    return token != null;
  }
}
