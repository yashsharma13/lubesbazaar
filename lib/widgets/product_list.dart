import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/services/product_service.dart';
import 'package:lubes_bazaar/models/product_model.dart';
import 'package:lubes_bazaar/widgets/custom_appbar.dart';
import 'package:lubes_bazaar/widgets/custom_bottom_navbar.dart';
import 'package:lubes_bazaar/widgets/product_details.dart';
import 'package:lubes_bazaar/widgets/sidebar.dart';
import 'package:lubes_bazaar/widgets/custom_button.dart';
import 'package:lubes_bazaar/config/styles.dart'; // 👈 custom styles

class ProductListPage extends StatelessWidget {
  final String menuId;
  final String title;
  final String userId;
  final String token;

  const ProductListPage({
    super.key,
    required this.menuId,
    required this.title,
    required this.userId,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();

    return Scaffold(
      appBar: CustomAppBar(title: title, useGradient: true),
      drawer: const Sidebar(),
      body: FutureBuilder<List<ProductModel>>(
        future: productService.fetchProducts(userId, token, menuId),
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
            return const Center(
              child: Text("No products found", style: AppTextStyles.emptyState),
            );
          }

          final products = snapshot.data!;

          return GridView.builder(
            padding: AppPadding.screen,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailPage(product: p),
                    ),
                  );
                },
                child: Container(
                  decoration: AppDecorations.card, // 👈 custom card style
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: p.imageUrl.isNotEmpty
                              ? Image.network(
                                  p.imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          size: 50,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              p.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.cartTitle,
                            ),
                            const SizedBox(height: AppSpacing.xs),

                            // Price + MRP
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Price Rs.",
                                      style: AppTextStyles.cartSubtitle,
                                    ),
                                    Text(
                                      "200",
                                      style: AppTextStyles.cartTitle.copyWith(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "MRP Rs.",
                                      style: AppTextStyles.cartSubtitle
                                          .copyWith(
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                    ),
                                    Text(
                                      "250",
                                      style: AppTextStyles.cartSubtitle
                                          .copyWith(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.red,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),

                            // Add to Cart button
                            CustomButton(
                              text: "Add to Cart",
                              height: 38,
                              width: double.infinity,
                              useGradient: true,
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${p.title} added to cart",
                                      style: AppTextStyles.body,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
