import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/data/dummy_data.dart';
import 'package:gerenciamento_de_estado/models/product.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://shop-ferps53-default-rtdb.firebaseio.com/';
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

  Future<void> addProduct(Product product) {
    final future = http.post(
      Uri.parse('$_baseUrl/products.json'),
      body: jsonEncode(
        {
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'iamgeUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        },
      ),
    );

    return future.then<void>((response) {
      final id = jsonDecode(response.body)['name'];
      _items.add(
        Product(
          description: product.description,
          id: id,
          title: product.title,
          imageUrl: product.imageUrl,
          price: product.price,
        ),
      );
      notifyListeners();
    });
  }

  Future<void> updateProduct(Product newProduct) {
    int index = _items.indexWhere(
      (element) => element.id == newProduct.id,
    );

    if (index >= 0) {
      _items[index] = newProduct;
      notifyListeners();
    }
    return Future.value();
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

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
      description: data['description'] as String,
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['title'] as String,
      imageUrl: data['imageUrl'] as String,
      price: data['price'] as double,
    );

    if (hasId) {
      return updateProduct(newProduct);
    } else {
      return addProduct(newProduct);
    }
  }
}
