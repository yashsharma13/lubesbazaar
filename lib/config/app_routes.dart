import 'package:flutter/material.dart';
import 'package:lubes_bazaar/screens/auth/Forget_password/forget_password.dart';
import 'package:lubes_bazaar/screens/auth/register/registeration.dart';
import 'package:lubes_bazaar/screens/checkout/checkout.dart';
import 'package:lubes_bazaar/screens/home/home.dart';
import 'package:lubes_bazaar/screens/profile/profile_page.dart';
import '../screens/auth/login/login.dart';

class AppRoutes {
  static const String register = '/register';
  static const String login = '/login';
  static const String forgetpassword = '/forgetpassword';
  static const String profile = '/profile';
  static const String home = '/home';
  static const String industrial = 'industrial';
  static const String checkout = '/checkout';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case forgetpassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordPage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case home:
        return MaterialPageRoute(builder: (_) => const Homepage());

      case checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutPage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
