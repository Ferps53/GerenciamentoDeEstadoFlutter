import 'package:flutter/material.dart';
import '../widget/product_grid.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverViewScreen extends StatefulWidget {
  const ProductOverViewScreen({super.key});

  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: [
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorite,
                child: Text("Somente Favoritos"),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text("Todos"),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
        ],
        title: const Text(
          "Minha Loja!",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}
