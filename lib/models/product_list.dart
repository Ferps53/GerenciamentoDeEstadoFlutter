import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/data/dummy_data.dart';
import 'package:gerenciamento_de_estado/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product newProduct) {
    int index = _items.indexWhere(
      (element) => element.id == newProduct.id,
    );

    if (index >= 0) {
      _items[index] = newProduct;
      notifyListeners();
    }
  }

  void removeProduct(Product oldProduct) {
    int index = _items.indexWhere((element) => element.id == oldProduct.id);

    if (index >= 0) {
      _items.removeWhere(
        (p) => p.id == oldProduct.id,
      );
      notifyListeners();
    }
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
      description: data['description'] as String,
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['title'] as String,
      imageUrl: data['imageUrl'] as String,
      price: data['price'] as double,
    );

    if (hasId) {
      updateProduct(newProduct);
    } else {
      addProduct(newProduct);
    }
  }
}
