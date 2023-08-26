import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/utils/exceptions/http_exception.dart';
import 'package:gerenciamento_de_estado/utils/url.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.description,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String uid) async {
    _toggleFavorite();
    final response = await http.put(
      Uri.parse(
        "${UrlList.USER_FAVORITE}/$uid/$id.json?auth=$token",
      ),
      body: jsonEncode(isFavorite),
    );

    if (response.statusCode >= 400) {
      _toggleFavorite();
      throw HttpException(
          msg: "Erro de Servidor :(", statusCode: response.statusCode);
    }
  }
}
