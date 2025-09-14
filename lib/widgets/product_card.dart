import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/styles.dart';
import 'package:lubes_bazaar/widgets/custom_button.dart';

class ProductCard extends StatelessWidget {
  final String discount;
  final String title;
  final String description;
  final String price;
  final String oldPrice;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.discount,
    required this.title,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 260,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: AppDecorations.card, // 👈 custom card style
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Discount Badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                discount,
                style: AppTextStyles.buttonText.copyWith(fontSize: 12),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),

            // 🔹 Product Image Placeholder
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryDark.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.shopping_bag,
                color: AppColors.primaryLight,
                size: 32,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),

            // 🔹 Title & Description
            Text(
              title,
              style: AppTextStyles.cartTitle.copyWith(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              description,
              style: AppTextStyles.cartSubtitle.copyWith(fontSize: 11),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.xs),

            // 🔹 Price Labels Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Price:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary,
                  ),
                ),
                Text(
                  "Old Price:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),

            // 🔹 Price Values Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: AppTextStyles.cartTitle.copyWith(
                    fontSize: 14,
                    color: AppColors.primaryLight,
                  ),
                ),
                Text(
                  oldPrice,
                  style: AppTextStyles.cartSubtitle.copyWith(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 13,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // 🔹 Custom Add to Cart Button
            CustomButton(
              text: "ADD TO CART",
              onPressed: onAddToCart, // ✅ use callback
              height: 36,
              width: double.infinity,
              useGradient: true,
            ),
          ],
        ),
      ),
    );
  }
}
