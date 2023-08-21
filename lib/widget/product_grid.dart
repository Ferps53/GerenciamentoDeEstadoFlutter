
import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/product_list.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import 'product_item.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
        final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: loadedProducts.length,
      itemBuilder: (context, index) =>
          ProductItem(product: loadedProducts[index]),
    );
  }
}