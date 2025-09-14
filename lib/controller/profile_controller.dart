import 'package:flutter/material.dart';
import 'package:lubes_bazaar/models/user_model.dart';
import 'package:lubes_bazaar/services/profile_service.dart';

class UserController extends ChangeNotifier {
  final UserService _service = UserService();

  UserModel? currentUser;
  bool isLoading = false;

  /// 🔹 User load karna (login ke baad)
  Future<void> loadUser(UserModel user) async {
    currentUser = user;
    debugPrint("👤 User loaded into controller: ${user.toJson()}");
    notifyListeners();
  }

  /// 🔹 App restart hone ke baad token se user fetch karna
  Future<void> fetchUserFromToken() async {
    isLoading = true;
    notifyListeners();

    final user = await _service.getProfile();
    if (user != null) {
      currentUser = user;
      debugPrint("✅ User fetched from token: ${user.toJson()}");
    } else {
      debugPrint("❌ Failed to fetch user from token");
    }

    isLoading = false;
    notifyListeners();
  }

  /// 🔹 Update Profile
  Future<void> updateProfile(UserModel user, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    debugPrint("✏️ Updating profile with data: ${user.toJson()}");

    final updatedUser = await _service.updateProfile(user);
    isLoading = false;

    if (updatedUser != null) {
      // 🔹 Preserve old token & userId
      currentUser =
          currentUser?.copyWith(
            fname: updatedUser.fname,
            lname: updatedUser.lname,
            email: updatedUser.email,
            phone: updatedUser.phone,
            token: updatedUser.token ?? currentUser!.token,
            id: updatedUser.id != 0 ? updatedUser.id : currentUser!.id,
          ) ??
          updatedUser;

      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Profile updated successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Failed to update profile")),
      );
    }
  }

  /// 🔹 Change Password
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    if (currentUser == null) return;

    isLoading = true;
    notifyListeners();

    debugPrint("🔑 Changing password for userId=${currentUser!.id}");
    final success = await _service.changePassword(
      userId: currentUser?.id,
      token: currentUser?.token,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    isLoading = false;
    notifyListeners();

    if (success) {
      debugPrint("✅ Password updated successfully");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Password updated successfully")),
      );
    } else {
      debugPrint("❌ Failed to change password");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Failed to change password")),
      );
    }
  }
}
