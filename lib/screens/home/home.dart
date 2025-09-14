//
//import 'package:flutter/material.dart';
// import 'package:lubes_bazaar/config/app_colors.dart';
// import 'package:lubes_bazaar/config/styles.dart';
// import 'package:lubes_bazaar/controller/cart_controller.dart';
// import 'package:lubes_bazaar/controller/product_controller.dart';
// import 'package:lubes_bazaar/widgets/custom_appbar.dart';
// import 'package:lubes_bazaar/widgets/custom_bottom_navbar.dart';
// import 'package:lubes_bazaar/widgets/product_card.dart';
// import 'package:lubes_bazaar/widgets/sidebar.dart';
// import 'package:provider/provider.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({Key? key}) : super(key: key);

//   @override
//   State<Homepage> createState() => _HomePageState();
// }

// class _HomePageState extends State<Homepage> {
//   @override
//   void initState() {
//     super.initState();
//     // ✅ Login ke baad products load karna
//     Future.microtask(
//       () => Provider.of<ProductController>(
//         context,
//         listen: false,
//       ).loadTopSellingProducts(),
//     );
//   }

//   final List<String> bannerImages = [
//     "assets/images/banner1.png",
//     "assets/images/banner2.jpg",
//     "assets/images/banner3.png",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final productController = Provider.of<ProductController>(context);

//     return Scaffold(
//       appBar: const CustomAppBar(title: "Lubes Bazzar", useGradient: true),
//       drawer: const Sidebar(),
//       body: SingleChildScrollView(
//         padding: AppPadding.screen,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 🔹 Carousel
//             CarouselSlider(
//               options: CarouselOptions(
//                 height: Responsive.isMobile(context) ? 160 : 220,
//                 autoPlay: true,
//                 autoPlayInterval: const Duration(seconds: 3),
//                 enlargeCenterPage: true,
//                 viewportFraction: 1,
//               ),
//               items: bannerImages.map((item) {
//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.asset(
//                     item,
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: AppSpacing.lg),

//             // 🔹 Top Selling Header Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Top Selling", style: AppTextStyles.heading),
//                 GestureDetector(
//                   onTap: () {
//                     productController.toggleExpand();
//                   },
//                   child: Text(
//                     productController.isExpanded ? "Show Less" : "View All",
//                     style: AppTextStyles.link,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: AppSpacing.md),

//             // 🔹 Products List
//             SizedBox(
//               height: Responsive.isMobile(context) ? 260 : 320,
//               child: productController.isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: productController.visibleProducts.length,
//                       separatorBuilder: (_, __) =>
//                           const SizedBox(width: AppSpacing.md),
//                       itemBuilder: (context, index) {
//                         final product =
//                             productController.visibleProducts[index];
//                         return ProductCard(
//                           discount: product.discount,
//                           title: product.title,
//                           description: product.description,
//                           price: "₹${product.price}",
//                           oldPrice: "₹${product.oldPrice}",
//                           onAddToCart: () {
//                             final cartController = Provider.of<CartController>(
//                               context,
//                               listen: false,
//                             );

//                             final alreadyInCart = cartController.cartItems.any(
//                               (item) => item.id == product.id,
//                             );

//                             if (alreadyInCart) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text(
//                                     "⚠️ Product is already in the cart",
//                                   ),
//                                   backgroundColor: AppColors.primary,
//                                   duration: Duration(seconds: 2),
//                                 ),
//                               );
//                             } else {
//                               cartController.addToCart(product);
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text("✅ Product added to cart"),
//                                   backgroundColor: AppColors.primaryLight,
//                                   duration: Duration(seconds: 2),
//                                 ),
//                               );
//                             }
//                           },
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/styles.dart';
import 'package:lubes_bazaar/controller/cart_controller.dart';
import 'package:lubes_bazaar/controller/product_controller.dart';
import 'package:lubes_bazaar/services/auth_service.dart';
import 'package:lubes_bazaar/config/app_routes.dart';
import 'package:lubes_bazaar/widgets/custom_appbar.dart';
import 'package:lubes_bazaar/widgets/custom_bottom_navbar.dart';
import 'package:lubes_bazaar/widgets/product_card.dart';
import 'package:lubes_bazaar/widgets/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    // ✅ Login ke baad products load karna
    Future.microtask(
      () => Provider.of<ProductController>(
        context,
        listen: false,
      ).loadTopSellingProducts(),
    );
  }

  final List<String> bannerImages = [
    "assets/images/banner1.png",
    "assets/images/banner2.jpg",
    "assets/images/banner3.png",
  ];

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);

    return WillPopScope(
      onWillPop: () async {
        // ✅ back button press → logout via UserService
        final authService = AuthService();
        await authService.logoutUser();

        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => false,
        );
        return false; // prevent going back
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: "Lubes Bazaar", useGradient: true),
        drawer: const Sidebar(),
        body: SingleChildScrollView(
          padding: AppPadding.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Carousel
              CarouselSlider(
                options: CarouselOptions(
                  height: Responsive.isMobile(context) ? 160 : 220,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                ),
                items: bannerImages.map((item) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 🔹 Top Selling Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top Selling", style: AppTextStyles.heading),
                  GestureDetector(
                    onTap: () {
                      productController.toggleExpand();
                    },
                    child: Text(
                      productController.isExpanded ? "Show Less" : "View All",
                      style: AppTextStyles.link,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // 🔹 Products List
              SizedBox(
                height: Responsive.isMobile(context) ? 260 : 320,
                child: productController.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: productController.visibleProducts.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: AppSpacing.md),
                        itemBuilder: (context, index) {
                          final product =
                              productController.visibleProducts[index];
                          return ProductCard(
                            discount: product.discount,
                            title: product.title,
                            description: product.description,
                            price: "₹${product.price}",
                            oldPrice: "₹${product.oldPrice}",
                            onAddToCart: () {
                              final cartController =
                                  Provider.of<CartController>(
                                    context,
                                    listen: false,
                                  );

                              final alreadyInCart = cartController.cartItems
                                  .any((item) => item.id == product.id);

                              if (alreadyInCart) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "⚠️ Product is already in the cart",
                                    ),
                                    backgroundColor: AppColors.primary,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                cartController.addToCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("✅ Product added to cart"),
                                    backgroundColor: AppColors.primaryLight,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      ),
    );
  }
}
