// import 'package:flutter/material.dart';
// import 'package:lubes_bazaar/widgets/custom_appbar.dart';
// import 'package:lubes_bazaar/widgets/custom_bottom_navbar.dart';
// import 'package:lubes_bazaar/widgets/product_card.dart';
// import 'package:lubes_bazaar/widgets/sidebar.dart';
// import 'package:lubes_bazaar/models/product_model.dart';
// import 'package:lubes_bazaar/services/product_service.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   final ProductService _productService = ProductService();
//   final TextEditingController _searchController = TextEditingController();

//   List<ProductModel> _products = [];
//   bool _isLoading = false;

//   Future<void> _searchProducts(String keyword) async {
//     setState(() => _isLoading = true);
//     final results = await _productService.fetchSearchProducts(keyword);
//     setState(() {
//       _products = results;
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(title: "Search", useGradient: true),
//       drawer: const Sidebar(),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // 🔍 Search Bar
//             TextField(
//               controller: _searchController,
//               onSubmitted: _searchProducts,
//               decoration: InputDecoration(
//                 hintText: "Search for products",
//                 prefixIcon: const Icon(Icons.search),
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () => _searchProducts(_searchController.text),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             // 🔹 Product List
//             Expanded(
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : _products.isEmpty
//                   ? const Center(child: Text("No products found"))
//                   : ListView.separated(
//                       itemCount: _products.length,
//                       separatorBuilder: (_, __) => const SizedBox(height: 12),
//                       itemBuilder: (context, index) {
//                         final product = _products[index];
//                         return ProductCard(
//                           discount: product.discount,
//                           title: product.title,
//                           description: product.description.isNotEmpty
//                               ? product.description
//                               : "No description",
//                           price: "₹${product.price}",
//                           oldPrice: "₹${product.oldPrice}",
//                           onAddToCart: () {},
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/widgets/custom_appbar.dart';
import 'package:lubes_bazaar/widgets/custom_bottom_navbar.dart';
import 'package:lubes_bazaar/widgets/product_card.dart';
import 'package:lubes_bazaar/widgets/sidebar.dart';
import 'package:lubes_bazaar/models/product_model.dart';
import 'package:lubes_bazaar/services/product_service.dart';
import 'package:lubes_bazaar/config/styles.dart'; // 👈 Import styles

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ProductService _productService = ProductService();
  final TextEditingController _searchController = TextEditingController();

  List<ProductModel> _products = [];
  bool _isLoading = false;

  Future<void> _searchProducts(String keyword) async {
    setState(() => _isLoading = true);
    final results = await _productService.fetchSearchProducts(keyword);
    setState(() {
      _products = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Search", useGradient: true),
      drawer: const Sidebar(),
      body: Padding(
        padding: AppPadding.screen, // 👈 use custom padding
        child: Column(
          children: [
            // 🔍 Search Bar
            TextField(
              controller: _searchController,
              onSubmitted: _searchProducts,
              style: AppTextStyles.body, // 👈 centralized text style
              decoration: AppSearchStyles.searchInputDecoration.copyWith(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: AppColors.grey),
                  onPressed: () => _searchProducts(_searchController.text),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // 🔹 Product List
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _products.isEmpty
                  ? Center(
                      child: Text(
                        "No products found",
                        style: AppTextStyles.emptyState, // 👈 style
                      ),
                    )
                  : ListView.separated(
                      itemCount: _products.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        return ProductCard(
                          discount: product.discount,
                          title: product.title,
                          description: product.description.isNotEmpty
                              ? product.description
                              : "No description",
                          price: "₹${product.price}",
                          oldPrice: "₹${product.oldPrice}",
                          onAddToCart: () {},
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }
}
