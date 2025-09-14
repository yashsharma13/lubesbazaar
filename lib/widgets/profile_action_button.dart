import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/styles.dart'; // 👈 custom styles

class ProfileActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isExpanded;

  const ProfileActionButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.md,
        ),
        side: const BorderSide(color: AppColors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.body.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(
            isExpanded ? Icons.remove : Icons.add,
            color: AppColors.primaryDark,
          ),
        ],
      ),
    );
  }
}
