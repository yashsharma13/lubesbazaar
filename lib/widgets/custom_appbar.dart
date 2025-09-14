import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/styles.dart'; // 👈 custom styles import

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool useGradient;
  final List<Widget>? actions;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.useGradient = false,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final Widget appBarContent = AppBar(
      backgroundColor: useGradient ? Colors.transparent : AppColors.white,
      elevation: useGradient ? 0 : 1,
      leading:
          leading ??
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),

      /// ✅ Title Style from AppTextStyles
      title: Text(
        title,
        style: AppTextStyles.heading.copyWith(
          fontSize: 18,
          color: AppColors.white,
        ),
      ),

      centerTitle: true,

      /// ✅ Default Actions
      actions:
          actions ??
          [
            IconButton(
              icon: const Icon(
                Icons.shopping_bag_outlined,
                color: AppColors.white,
              ),
              onPressed: () {},
            ),
          ],
    );

    /// ✅ Gradient Background
    if (useGradient) {
      return Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: appBarContent,
      );
    }

    return appBarContent;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
