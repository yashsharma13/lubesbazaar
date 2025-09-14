import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/app_routes.dart';
import 'package:lubes_bazaar/config/styles.dart';
import 'package:lubes_bazaar/controller/cart_controller.dart';
import 'package:lubes_bazaar/widgets/custom_appbar.dart';
import 'package:lubes_bazaar/widgets/custom_bottom_navbar.dart';
import 'package:lubes_bazaar/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:lubes_bazaar/models/product_model.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'My Cart', useGradient: true),
      body: cart.cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty",
                style: AppTextStyles.emptyState,
              ),
            )
          : ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) {
                final ProductModel product = cart.cartItems[index];
                return Container(
                  margin: const EdgeInsets.all(AppSpacing.sm),
                  decoration: AppDecorations.card,
                  child: ListTile(
                    title: Text(product.title, style: AppTextStyles.cartTitle),
                    subtitle: Text(
                      "${product.price} x ${product.quantity}",
                      style: AppTextStyles.cartSubtitle,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: AppColors.red),
                          onPressed: () => cart.decreaseQuantity(product),
                        ),
                        Text("${product.quantity}", style: AppTextStyles.body),
                        IconButton(
                          icon: const Icon(Icons.add, color: AppColors.green),
                          onPressed: () => cart.increaseQuantity(product),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: CustomButton(
              text: "PLACE THIS ORDER : ${cart.totalPrice.toStringAsFixed(2)}",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.checkout);
              },
              height: 50,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const CustomBottomNavBar(currentIndex: 2),
        ],
      ),
    );
  }
}
