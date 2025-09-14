import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/styles.dart';
import 'package:lubes_bazaar/widgets/app_logo.dart';
import 'package:lubes_bazaar/widgets/custom_text_field.dart';
import 'package:lubes_bazaar/widgets/custom_button.dart';
import 'package:lubes_bazaar/utils/validators.dart';
import 'package:lubes_bazaar/utils/helpers.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

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
                  margin: EdgeInsets.only(
                    top: AppSpacing.lg,
                    bottom: AppSpacing.sm,
                  ),
                ),

                Text("FORGET PASSWORD", style: AppTextStyles.authTitle),
                const SizedBox(height: AppSpacing.xl),

                /// Email field
                CustomTextField(
                  hint: "Email Address",
                  controller: _emailController,
                  validator: Validators.email,
                ),
                const SizedBox(height: AppSpacing.md),

                /// Submit Button
                CustomButton(
                  text: "SUBMIT",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Helpers.showSnack(
                        context,
                        "Password reset link sent to ${_emailController.text}",
                      );
                    }
                  },
                  useGradient: false,
                  customColor: AppColors.primary,
                ),
                const SizedBox(height: AppSpacing.sm),

                /// Back Button
                CustomButton(
                  text: "BACK",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  height: 50,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
