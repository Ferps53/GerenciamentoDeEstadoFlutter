import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/product.dart';
import 'package:gerenciamento_de_estado/utils/http_exception.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://shop-ferps53-default-rtdb.firebaseio.com/products';
  final List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse("$_baseUrl.json"));
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      _items.add(
        Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          imageUrl: productData['iamgeUrl'],
          price: productData['price'],
          isFavorite: productData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse("$_baseUrl.json"),
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
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere(
      (element) => element.id == product.id,
    );

    if (index >= 0) {
      await http.patch(
        Uri.parse("$_baseUrl/${product.id}.json"),
        body: jsonEncode({
          "description": product.description,
          "title": product.title,
          "imageUrl": product.imageUrl,
          "price": product.price,
        }),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  /*Esse é o modelo de deleção Otmista, 
    ele consiste em deletar o produto no front antes do backend.
    Dessa forma, o front tem um visual mais ágil!
  */
  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse("$_baseUrl/${product.id}.json"),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
            msg: "Não foi possível excluir produto!",
            statusCode: response.statusCode);
      }
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
