import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/models/product_model.dart';
import 'package:lubes_bazaar/widgets/custom_appbar.dart';
import 'package:lubes_bazaar/widgets/custom_bottom_navbar.dart';
import 'package:lubes_bazaar/widgets/custom_button.dart';
import 'package:lubes_bazaar/widgets/sidebar.dart';
import 'package:lubes_bazaar/config/styles.dart'; // 👈 custom styles

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.title, useGradient: true),
      drawer: const Sidebar(),
      body: SingleChildScrollView(
        padding: AppPadding.form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image
            Center(
              child: product.imageUrl.isNotEmpty
                  ? Image.network(
                      product.imageUrl,
                      height: 220,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                          size: 100,
                          color: AppColors.grey,
                        );
                      },
                    )
                  : const Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: AppColors.grey,
                    ),
            ),
            const SizedBox(height: AppSpacing.md),

            /// Title
            Text(
              product.title,
              style: AppTextStyles.heading.copyWith(fontSize: 22),
            ),
            const SizedBox(height: AppSpacing.sm),

            /// Description
            if (product.description.isNotEmpty)
              Text(product.description, style: AppTextStyles.body),
            const SizedBox(height: AppSpacing.md),

            /// Pricing Section
            Text(
              "Price: ₹${product.price}",
              style: AppTextStyles.cartTitle.copyWith(
                color: AppColors.green,
                fontSize: 18,
              ),
            ),
            Text(
              "Old Price: ₹${product.oldPrice}",
              style: AppTextStyles.cartSubtitle.copyWith(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            if (product.discount.isNotEmpty)
              Text(
                "Discount: ${product.discount}% OFF",
                style: AppTextStyles.cartSubtitle.copyWith(
                  color: AppColors.red,
                ),
              ),
            if (product.discPrice != null)
              Text(
                "Discounted Price: ₹${product.discPrice}",
                style: AppTextStyles.cartTitle.copyWith(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),

            const Divider(height: AppSpacing.lg),

            /// Extra Product Info
            if (product.fuel != null)
              Text("Fuel Type: ${product.fuel}", style: AppTextStyles.body),
            Text(
              "Available Qty: ${product.quantity}",
              style: AppTextStyles.body,
            ),
            if (product.packSize != null)
              Text("Pack Size: ${product.packSize}", style: AppTextStyles.body),
            if (product.unit != null && product.subunit != null)
              Text(
                "Unit: ${product.unit} / ${product.subunit}",
                style: AppTextStyles.body,
              ),
            if (product.productCode != null)
              Text(
                "Product Code: ${product.productCode}",
                style: AppTextStyles.body,
              ),
            if (product.batchNumber != null)
              Text(
                "Batch No: ${product.batchNumber}",
                style: AppTextStyles.body,
              ),

            const SizedBox(height: AppSpacing.lg),

            /// Add to Cart
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Add to Cart",
                onPressed: () {
                  // TODO: Add to cart logic
                },
                height: 48,
                useGradient: true,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
