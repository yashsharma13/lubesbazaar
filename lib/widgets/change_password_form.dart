import 'package:flutter/material.dart';
import 'package:lubes_bazaar/controller/profile_controller.dart';
import 'package:lubes_bazaar/widgets/custom_button.dart';
import 'package:lubes_bazaar/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:lubes_bazaar/config/styles.dart'; // 👈 custom styles import

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.sm),
      decoration: AppDecorations.card, // 👈 custom card style
      child: Padding(
        // padding: AppPadding.form, // 👈 custom padding
        padding: AppPadding.form.copyWith(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Change Password",
              style: AppTextStyles.heading.copyWith(
                // 👈 custom text style
                fontSize: 18,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            /// ✅ Old Password
            CustomTextField(
              hint: "Old Password",
              isPassword: true,
              controller: oldPasswordController,
            ),

            /// ✅ New Password
            CustomTextField(
              hint: "New Password",
              isPassword: true,
              controller: newPasswordController,
            ),

            /// ✅ Confirm Password
            CustomTextField(
              hint: "Confirm Password",
              isPassword: true,
              controller: confirmPasswordController,
            ),

            const SizedBox(height: AppSpacing.md),

            /// ✅ Button / Loader
            userController.isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: "Update Password",
                    useGradient: true, // 👈 gradient button
                    onPressed: () {
                      if (newPasswordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("❌ Passwords do not match"),
                          ),
                        );
                        return;
                      }
                      userController.changePassword(
                        oldPassword: oldPasswordController.text,
                        newPassword: newPasswordController.text,
                        context: context,
                      );
                    },
                  ),
            SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}
