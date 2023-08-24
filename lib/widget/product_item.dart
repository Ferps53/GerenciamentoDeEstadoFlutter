import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/utils/app_routes.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: product,
                );
              },
              icon: const Icon(
                color: Colors.purple,
                Icons.edit,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                color: Theme.of(context).colorScheme.error,
                Icons.delete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
