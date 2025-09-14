import 'package:flutter/material.dart';
import 'package:lubes_bazaar/widgets/change_password_form.dart';
import 'package:lubes_bazaar/widgets/custom_appbar.dart';
import 'package:lubes_bazaar/widgets/custom_bottom_navbar.dart';
import 'package:lubes_bazaar/widgets/edit_profile_form.dart';
import 'package:lubes_bazaar/widgets/profile_action_button.dart';
import 'package:lubes_bazaar/widgets/sidebar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showEditProfile = true;
  bool showChangePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Profile", useGradient: true),
      drawer: const Sidebar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Edit Profile
            ProfileActionButton(
              title: "Edit Profile",
              isExpanded: showEditProfile,
              onPressed: () {
                setState(() {
                  showEditProfile = !showEditProfile;
                  showChangePassword = false;
                });
              },
            ),
            if (showEditProfile) const EditProfileForm(),
            const SizedBox(height: 16),

            // Change Password
            ProfileActionButton(
              title: "Create Password",
              isExpanded: showChangePassword,
              onPressed: () {
                setState(() {
                  showChangePassword = !showChangePassword;
                  showEditProfile = false;
                });
              },
            ),
            if (showChangePassword) const ChangePasswordForm(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }
}
