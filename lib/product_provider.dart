import 'package:flutter/cupertino.dart';
import 'package:news_app/product_service.dart';

import 'news_model.dart';

class ProductProvider with ChangeNotifier {
  List<Articles> _products = [];
  bool _isLoading = false;

  List<Articles> get products => _products;
  bool get isLoading => _isLoading;

  final ProductService _productService = ProductService();

  Future<void> fetchProducts() async {
    _isLoading = true;
    _products = await _productService.fetchProducts();
    _isLoading = false;

    notifyListeners();
  }
}