import 'package:flutter/material.dart';
import 'package:lubes_bazaar/controller/profile_controller.dart';
import 'package:lubes_bazaar/models/user_model.dart';
import 'package:lubes_bazaar/widgets/custom_button.dart';
import 'package:lubes_bazaar/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:lubes_bazaar/config/styles.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserController>(
      context,
      listen: false,
    ).currentUser;
    if (user != null) {
      firstNameController.text = user.fname;
      lastNameController.text = user.lname;
      emailController.text = user.email;
      phoneController.text = user.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.sm),
      decoration: AppDecorations.card, // 👈 custom card style
      child: Padding(
        // padding: AppPadding.form,
        padding: AppPadding.form.copyWith(top: 24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit Profile",
              style: AppTextStyles.heading.copyWith(
                fontSize: 18,
              ), // 👈 custom text style
            ),
            const SizedBox(height: AppSpacing.sm),

            /// ✅ Fields
            CustomTextField(
              hint: "First Name",
              controller: firstNameController,
            ),
            CustomTextField(hint: "Last Name", controller: lastNameController),
            CustomTextField(hint: "Email", controller: emailController),
            CustomTextField(hint: "Phone Number", controller: phoneController),

            const SizedBox(height: AppSpacing.md),

            /// ✅ Buttons / Loader
            userController.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "Save",
                          onPressed: () {
                            final updatedUser = UserModel(
                              id: userController.currentUser!.id,
                              fname: firstNameController.text,
                              lname: lastNameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              token: userController.currentUser!.token,
                            );
                            userController.updateProfile(updatedUser, context);
                          },
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: CustomButton(
                          text: "Cancel",
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          useGradient: false,
                          customColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}
