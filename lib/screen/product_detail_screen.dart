import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          product.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
