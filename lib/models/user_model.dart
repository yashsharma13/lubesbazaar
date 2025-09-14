import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserModel {
  final int id;
  final String? token;
  final String fname;
  final String lname;
  final String email;
  final String phone;

  UserModel({
    required this.id,
    this.token,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
  });

  /// 🔹 Factory constructor for parsing JSON (without token)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["user_id"] ?? json["userId"] ?? 0,
      token: json["token"],
      fname: json["fname"] ?? "",
      lname: json["lname"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
    );
  }

  /// 🔹 Convert model to JSON (for API calls)
  Map<String, dynamic> toJson() {
    return {
      "userId": id,
      "token": token,
      "fname": fname,
      "lname": lname,
      "email": email,
      "phone": phone,
    };
  }

  /// 🔹 Safe update (preserve old values if new ones missing)
  UserModel copyWith({
    int? id,
    String? token,
    String? fname,
    String? lname,
    String? email,
    String? phone,
  }) {
    return UserModel(
      id: id ?? this.id,
      token: token ?? this.token,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  /// 🔹 Debug print helper
  Map<String, dynamic> toDebugJson() => {
    "userId": id,
    "token": token,
    "fname": fname,
    "lname": lname,
    "email": email,
    "phone": phone,
  };
}

/// ✅ Extension for handling token injection from secure storage
extension UserModelWithAuth on UserModel {
  static final _storage = const FlutterSecureStorage();

  /// Load user from API JSON and inject token from storage
  static Future<UserModel> fromJsonWithAuth(Map<String, dynamic> json) async {
    final token = await _storage.read(key: "token"); // 🔑 get saved token
    return UserModel(
      id: json["user_id"] ?? json["userId"] ?? 0,
      token: token, // ✅ inject token
      fname: json["fname"] ?? "",
      lname: json["lname"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
    );
  }
}
