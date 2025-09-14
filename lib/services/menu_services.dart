import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lubes_bazaar/models/menu_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lubes_bazaar/services/api_endpoints.dart';

class ApiService {
  static final String baseUrl = ApiEndpoints.menu;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<List<MenuItem>> fetchMenu() async {
    try {
      // 🔐 Read userId and token from secure storage
      final userId = await storage.read(key: "user_id");
      final token = await storage.read(key: "auth_token");

      print("🔑 user_id: $userId, token: $token");

      if (userId == null || token == null) {
        throw Exception("User not logged in.");
      }

      final payload = {
        "userdata": {"action": "getAllMenu", "userId": userId, "token": token},
      };

      print("➡️ Request Payload: ${jsonEncode(payload)}");

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      print("⬅️ Response Status: ${response.statusCode}");
      print("⬅️ Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // ✅ Some APIs return `dataInfo`, some `data`
        final menuRaw = data['dataInfo'] ?? data['data'];

        if ((data['status'] == '200' ||
                data['status'] == 200 ||
                data['type'] == true) &&
            menuRaw != null) {
          print("✅ Menus fetched: ${menuRaw.length}");
          return (menuRaw as List).map((e) => MenuItem.fromJson(e)).toList();
        } else {
          print("⚠️ No menu found or invalid status.");
          return [];
        }
      } else {
        throw Exception("❌ API error: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception caught in fetchMenu: $e");
      return [];
    }
  }
}
