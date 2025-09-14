import 'package:flutter/material.dart';
import 'package:lubes_bazaar/services/product_service.dart';
import 'package:lubes_bazaar/models/product_model.dart';

class ProductController extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<ProductModel> allTopSellingProducts = [];
  List<ProductModel> visibleProducts = [];
  bool isLoading = false;

  bool isExpanded = false;

  Future<void> loadTopSellingProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      allTopSellingProducts = await _service.fetchTopSellingProducts();

      // Sirf 10 products initially
      visibleProducts = allTopSellingProducts.take(10).toList();
    } catch (e) {
      allTopSellingProducts = [];
      visibleProducts = [];
    }

    isLoading = false;
    notifyListeners();
  }

  void toggleExpand() {
    if (isExpanded) {
      // Collapse back to 10
      visibleProducts = allTopSellingProducts.take(10).toList();
      isExpanded = false;
    } else {
      // Expand to all
      visibleProducts = List.from(allTopSellingProducts);
      isExpanded = true;
    }
    notifyListeners();
  }
}
