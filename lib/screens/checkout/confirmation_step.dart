import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/styles.dart';

class ConfirmationStep extends StatelessWidget {
  const ConfirmationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.lg),

        // ✅ Shipping To
        Container(
          decoration: AppDecorations.card,
          child: ListTile(
            title: Text("Shipping To", style: AppTextStyles.cartTitle),
            subtitle: Text(
              "John Smith\n701, Block-B, Sidhhi Vinayak Tower, Ahmedabad-380050",
              style: AppTextStyles.body,
            ),
            trailing: TextButton(
              onPressed: () {},
              child: Text("Edit", style: AppTextStyles.link),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // ✅ Your Order
        Container(
          decoration: AppDecorations.card,
          child: ListTile(
            leading: Image.asset(
              "assets/images/lubesbazaar.png",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text("Product Name", style: AppTextStyles.cartTitle),
            subtitle: Text(
              "Qty: 1\n₹ 11,196",
              style: AppTextStyles.cartSubtitle,
            ),
            trailing: TextButton(
              onPressed: () {},
              child: Text("Edit", style: AppTextStyles.link),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // ✅ Payment Summary
        Container(
          decoration: AppDecorations.card,
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Total", style: AppTextStyles.body),
                  Text("₹ 11,196", style: AppTextStyles.body),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Delivery Charge", style: AppTextStyles.body),
                  Text(
                    "Free",
                    style: AppTextStyles.body.copyWith(color: AppColors.green),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Amount", style: AppTextStyles.cartTitle),
                  Text(
                    "₹ 11,196",
                    style: AppTextStyles.cartTitle.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
