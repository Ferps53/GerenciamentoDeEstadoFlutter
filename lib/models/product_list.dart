import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/data/dummy_data.dart';
import 'package:gerenciamento_de_estado/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
