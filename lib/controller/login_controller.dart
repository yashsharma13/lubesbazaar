import 'package:flutter/material.dart';
import 'package:lubes_bazaar/models/user_model.dart';
import 'package:lubes_bazaar/services/auth_service.dart';

class LoginController {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  final AuthService _authService = AuthService();

  // 🔁 Return UserModel? instead of bool
  Future<UserModel?> login() async {
    final user = await _authService.loginUser(
      email: emailCtrl.text.trim(),
      password: passwordCtrl.text.trim(),
    );

    return user; // ✅ return full UserModel
  }

  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }
}
