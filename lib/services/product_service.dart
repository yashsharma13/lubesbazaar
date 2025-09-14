import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lubes_bazaar/models/product_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lubes_bazaar/services/api_endpoints.dart';

class ProductService {
  static final String baseUrl = ApiEndpoints.product;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  /// 🔹 Fetch Top Selling Products
  Future<List<ProductModel>> fetchTopSellingProducts() async {
    try {
      final userId = await storage.read(key: "user_id");
      final token = await storage.read(key: "auth_token");

      if (userId == null || token == null) {
        throw Exception("User not logged in.");
      }

      final payload = {
        "userdata": {
          "action": "getTopSallingProduct",
          "userId": userId,
          "token": token,
        },
      };

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final productsRaw = data['data'] ?? data['dataInfo'];

        if ((data['status'] == '200' || data['type'] == true) &&
            productsRaw != null) {
          return (productsRaw as List)
              .map((e) => ProductModel.fromJson(e))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception("API error: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception in fetchTopSellingProducts: $e");
      return [];
    }
  }

  /// 🔹 Fetch Product Details by ID (when clicked)
  Future<List<ProductModel>> fetchProducts(
    String userId,
    String token,
    String menuId,
  ) async {
    try {
      final payload = {
        "userdata": {
          "action": "getProductByMenu", // ✅ correct action
          "userId": userId,
          "token": token,
          "menuId": menuId,
          "level": "shoping",
          "sortby": "",
          "filterbyPrice": "",
          "filterbyBrand": "",
          "filterbyOiltype": "",
          "filterbyManufacturer": "",
        },
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
        final productsRaw = data['data'] ?? data['dataInfo'];

        if ((data['status'] == '200' || data['type'] == true) &&
            productsRaw != null) {
          return (productsRaw as List)
              .map((e) => ProductModel.fromJson(e))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception("API error: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception in fetchProducts: $e");
      return [];
    }
  }

  /// 🔹 Fetch Products by Search
  Future<List<ProductModel>> fetchSearchProducts(String keyword) async {
    try {
      final userId = await storage.read(key: "user_id");
      final token = await storage.read(key: "auth_token");

      if (userId == null || token == null) {
        throw Exception("User not logged in.");
      }

      final payload = {
        "userdata": {
          "action": "GetSearchResult",
          "keyword": keyword,
          "userId": userId,
          "token": token,
          "category": "",
        },
      };

      print("➡️ Search Payload: ${jsonEncode(payload)}");

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      print("⬅️ Search Response: ${response.statusCode}");
      print("⬅️ Search Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final productsRaw = data['data'] ?? data['dataInfo'];

        if ((data['status'] == '200' || data['type'] == true) &&
            productsRaw != null) {
          return (productsRaw as List)
              .map((e) => ProductModel.fromJson(e))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception("API error: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception in fetchSearchProducts: $e");
      return [];
    }
  }
}
