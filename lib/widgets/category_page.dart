import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/styles.dart'; // 👈 styles import
import 'package:lubes_bazaar/widgets/custom_appbar.dart';
import 'package:lubes_bazaar/widgets/custom_bottom_navbar.dart';
import 'package:lubes_bazaar/models/menu_model.dart';
import 'package:lubes_bazaar/widgets/product_list.dart';
import 'package:lubes_bazaar/widgets/sidebar.dart';

class CategoryPage extends StatelessWidget {
  final String title;
  final List<MenuItem> subcategories;

  const CategoryPage({
    super.key,
    required this.title,
    required this.subcategories,
  });

  Future<void> _navigateToProducts(
    BuildContext context,
    String menuId,
    String name,
  ) async {
    const storage = FlutterSecureStorage();

    final userId = await storage.read(key: "user_id");
    final token = await storage.read(key: "auth_token");

    if (userId != null && token != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductListPage(
            menuId: menuId,
            title: name,
            userId: userId,
            token: token,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("⚠️ User not logged in")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title, useGradient: true),
      drawer: const Sidebar(),

      body: SingleChildScrollView(
        padding: AppPadding.screen, // 👈 custom padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "MAIN CATEGORY",
                style: AppTextStyles.body.copyWith(
                  color: AppColors.primaryLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // ✅ Subcategory List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subcategories.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final sub = subcategories[index];
                return ListTile(
                  title: Text(
                    sub.name,
                    style: AppTextStyles.cartTitle, // 👈 custom style
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () => _navigateToProducts(context, sub.id, sub.name),
                );
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
