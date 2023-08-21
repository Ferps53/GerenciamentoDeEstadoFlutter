import 'package:flutter/material.dart';
import '../widget/product_grid.dart';

class ProductOverViewScreen extends StatelessWidget {
  
  const ProductOverViewScreen({super.key});

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text(
          "Minha Loja!",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:const ProductGrid(),
    );
  }
}

