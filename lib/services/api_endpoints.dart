import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  // 🔹 Base URL from .env
  static final String baseDomain =
      dotenv.env['BASE_URL'] ?? "http://default-url.com";

  // 🔹 User/Auth related APIs
  static String user = "$baseDomain/user";

  // 🔹 Menu APIs
  static String menu = "$baseDomain/menu";

  // 🔹 Product APIs
  static String product = "$baseDomain/product";

  // 🔹 Orders APIs (future me)
  static String orders = "$baseDomain/orders";
}

// class ApiEndpoints {
//   static const String baseDomain = "http://192.168.1.43:8000/api/v3";
//   // http://3.138.188.164/api/v3/product

//   // 🔹 User/Auth related APIs
//   static const String user = "$baseDomain/user";

//   // 🔹 Menu APIs
//   static const String menu = "$baseDomain/menu";

//   // 🔹 Product APIs
//   static const String product = "$baseDomain/product";

//   // 🔹 Orders APIs (future me)
//   static const String orders = "$baseDomain/orders";
// }
