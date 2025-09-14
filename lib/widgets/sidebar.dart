import 'package:flutter/material.dart';
import 'package:lubes_bazaar/models/menu_model.dart';
import 'package:lubes_bazaar/services/auth_service.dart';
import 'package:lubes_bazaar/services/menu_services.dart';
import 'package:lubes_bazaar/widgets/category_page.dart';
import 'package:lubes_bazaar/config/styles.dart';
import 'package:lubes_bazaar/config/app_colors.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();

    return Drawer(
      child: Column(
        children: [
          // 🔹 Drawer Header with gradient background + image
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/lubesbazaar.png',
                fit: BoxFit.contain,
                height: 220, // adjust as needed
              ),
            ),
          ),

          // 🔹 Menu items
          Expanded(
            child: SafeArea(
              child: FutureBuilder<List<MenuItem>>(
                future: apiService.fetchMenu(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                        style: AppTextStyles.body,
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "No menu found",
                        style: AppTextStyles.emptyState,
                      ),
                    );
                  }

                  final menuItems = snapshot.data!;
                  return ListView.builder(
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return ListTile(
                        leading: const Icon(
                          Icons.folder,
                          color: AppColors.primaryDark,
                        ),
                        title: Text(item.name, style: AppTextStyles.body),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(
                                title: item.name,
                                subcategories: item.subcategory,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),

          const Divider(),

          // 🔹 Logout button always at bottom
          SafeArea(
            top: false,
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                'Logout',
                style: AppTextStyles.body.copyWith(color: Colors.red),
              ),

              onTap: () async {
                // Show loading
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );

                // Call logout
                final service = AuthService();
                String? message = await service.logoutUser();

                // Close loading
                Navigator.pop(context);

                if (message != null) {
                  // ✅ Backend message snackBar me show kar do
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(message)));

                  // Agar logout successful tha toh login page le jao
                  if (message.toLowerCase().contains("logout successfully")) {
                    Navigator.pushReplacementNamed(
                      context,
                      '/login',
                      arguments: {'loggedOut': true},
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("❌ Unknown error during logout"),
                    ),
                  );
                }
              },
            ),
          ),

          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
}
