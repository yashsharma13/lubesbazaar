import 'package:flutter/material.dart';
import 'package:lubes_bazaar/services/auth_service.dart';
import 'package:lubes_bazaar/models/user_model.dart';

class RegisterController {
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final confirmEmailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  String accountType = "B2C"; // default

  final AuthService _authService = AuthService();

  // Add this getter to map "B2C"/"B2B" to int values
  int get accountTypeInt {
    if (accountType == "B2B") return 1;
    if (accountType == "B2C") return 2;
    return 0; // or throw error
  }

  Future<UserModel?> register() async {
    return await _authService.registerUser(
      acType: accountTypeInt.toString(),
      firstName: firstNameCtrl.text,
      lastName: lastNameCtrl.text,
      email: emailCtrl.text,
      password: passwordCtrl.text,
    );
  }
}
