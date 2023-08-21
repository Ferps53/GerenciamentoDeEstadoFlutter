import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/data/dummy_data.dart';
import 'package:gerenciamento_de_estado/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;
  bool _showFavoritesOnly = false;

  List<Product> get items {
    if (_showFavoritesOnly) {
      return _items.where((prod) => prod.isFavorite).toList();
    } else {
      return [..._items];
    }
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
