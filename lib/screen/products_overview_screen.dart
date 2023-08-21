import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/product_list.dart';
import 'package:provider/provider.dart';
import '../widget/product_grid.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverViewScreen extends StatelessWidget {
  const ProductOverViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: [
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: const Text("Somente Favoritos"),
                value: FilterOptions.Favorite,
              ),
              const PopupMenuItem(
                child: const Text("Todos"),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.Favorite) {
                provider.showFavoritesOnly();
              } else {
                provider.showAll();
              }
            },
          ),
        ],
        title: const Text(
          "Minha Loja!",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const ProductGrid(),
    );
  }
}
