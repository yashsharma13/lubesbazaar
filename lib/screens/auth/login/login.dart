// lib/screens/auth/login_page.dart
import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/styles.dart';
import 'package:lubes_bazaar/controller/login_controller.dart';
import 'package:lubes_bazaar/controller/profile_controller.dart';
import 'package:lubes_bazaar/widgets/custom_button.dart';
import 'package:lubes_bazaar/widgets/custom_text_field.dart';
import 'package:lubes_bazaar/utils/validators.dart';
import 'package:lubes_bazaar/config/app_routes.dart';
import 'package:lubes_bazaar/widgets/app_logo.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final LoginController _controller = LoginController();

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map && args['loggedOut'] == true) {
      Future.microtask(() {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Logout Successful")));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.form,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /// 🔹 Logo
                const AppLogo(
                  height: 180,
                  margin: EdgeInsets.only(top: AppSpacing.lg, bottom: 0),
                ),

                Text("LOGIN", style: AppTextStyles.authTitle),
                const SizedBox(height: AppSpacing.lg),

                /// Email
                CustomTextField(
                  hint: "Email",
                  controller: _controller.emailCtrl,
                  validator: Validators.email,
                ),

                /// Password
                CustomTextField(
                  hint: "Password",
                  controller: _controller.passwordCtrl,
                  isPassword: true,
                  validator: Validators.requiredField,
                ),

                const SizedBox(height: AppSpacing.md),

                /// Login Button
                CustomButton(
                  text: "LOGIN",
                  isLoading: _isLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _isLoading = true);

                      final user = await _controller.login();

                      if (!mounted) return;
                      setState(() => _isLoading = false);

                      if (user != null) {
                        final userController = Provider.of<UserController>(
                          context,
                          listen: false,
                        );
                        await userController.loadUser(user);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Successful")),
                        );

                        Navigator.pushNamed(context, AppRoutes.home);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Invalid Credentials")),
                        );
                      }
                    }
                  },
                  useGradient: false,
                  customColor: AppColors.primary,
                ),

                const SizedBox(height: AppSpacing.sm),

                /// Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.forgetpassword);
                    },
                    child: Text(
                      "Forgot Password?",
                      style: AppTextStyles.body.copyWith(color: Colors.black54),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.sm),

                /// Sign Up Button
                CustomButton(
                  text: "SIGN UP",
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
