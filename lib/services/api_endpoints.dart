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
