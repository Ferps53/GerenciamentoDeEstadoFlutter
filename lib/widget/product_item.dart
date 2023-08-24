import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/product_list.dart';
import 'package:gerenciamento_de_estado/utils/app_routes.dart';
import 'package:provider/provider.dart';

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
      trailing: SizedBox(
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Exluir Produto"),
                    content: const Text("Tem certeza?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Não"),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<ProductList>(
                            context,
                            listen: false,
                          ).removeProduct(product);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Sim"),
                      ),
                    ],
                  ),
                );
              },
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
