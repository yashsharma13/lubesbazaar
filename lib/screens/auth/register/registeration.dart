import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/app_routes.dart';
import 'package:lubes_bazaar/config/styles.dart'; // 👈 import styles.dart
import 'package:lubes_bazaar/widgets/app_logo.dart';
import 'package:lubes_bazaar/widgets/custom_button.dart';
import 'package:lubes_bazaar/widgets/custom_text_field.dart';
import 'package:lubes_bazaar/utils/validators.dart';
import 'package:lubes_bazaar/controller/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final RegisterController _controller = RegisterController();
  bool _isLoading = false;
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: AppPadding.screen, // 👈 use global padding
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const AppLogo(
                  height: 180,
                  margin: EdgeInsets.only(top: 2, bottom: 10),
                ),
                const SizedBox(height: AppSpacing.md),

                const Text(
                  "CREATE AN ACCOUNT",
                  style: AppTextStyles.heading,
                ), // 👈 style from styles.dart
                const SizedBox(height: AppSpacing.lg),

                // Account Type
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Account Type*", style: AppTextStyles.body),
                ),
                const SizedBox(height: AppSpacing.sm),

                Row(
                  children: [
                    Radio(
                      value: "B2B",
                      groupValue: _controller.accountType,
                      activeColor: AppColors.primaryDark,
                      onChanged: (val) =>
                          setState(() => _controller.accountType = val!),
                    ),
                    const Text("B2B"),
                    const SizedBox(width: AppSpacing.lg),
                    Radio(
                      value: "B2C",
                      groupValue: _controller.accountType,
                      activeColor: AppColors.primaryDark,
                      onChanged: (val) =>
                          setState(() => _controller.accountType = val!),
                    ),
                    const Text("B2C"),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),
                CustomTextField(
                  hint: "First Name*",
                  controller: _controller.firstNameCtrl,
                  validator: Validators.requiredField,
                ),
                CustomTextField(
                  hint: "Last Name*",
                  controller: _controller.lastNameCtrl,
                  validator: Validators.requiredField,
                ),
                CustomTextField(
                  hint: "Email Address*",
                  controller: _controller.emailCtrl,
                  validator: Validators.email,
                ),
                CustomTextField(
                  hint: "Confirm Email Address*",
                  controller: _controller.confirmEmailCtrl,
                  validator: (val) => val != _controller.emailCtrl.text
                      ? "Emails do not match"
                      : null,
                ),
                CustomTextField(
                  hint: "Password (Minimum 6 chars required)",
                  controller: _controller.passwordCtrl,
                  isPassword: true,
                  validator: Validators.password,
                ),

                const SizedBox(height: AppSpacing.sm),

                // Terms
                Row(
                  children: [
                    Checkbox(
                      value: agree,
                      onChanged: (val) => setState(() => agree = val!),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.secondary,
                          ),
                          children: [
                            const TextSpan(text: "I have read & agreed "),
                            TextSpan(
                              text: "Terms Of Service",
                              style: AppTextStyles.link,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                CustomButton(
                  text: "REGISTER",
                  isLoading: _isLoading,
                  useGradient: false,
                  customColor: AppColors.primary,
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && agree) {
                      setState(() => _isLoading = true);
                      final success = await _controller.register();
                      setState(() => _isLoading = false);

                      if (success != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Registration Successful"),
                          ),
                        );
                        Navigator.pushNamed(context, AppRoutes.login);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Registration Failed")),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fix errors")),
                      );
                    }
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppTextStyles.body,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.login),
                      child: const Text("Sign In", style: AppTextStyles.link),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
