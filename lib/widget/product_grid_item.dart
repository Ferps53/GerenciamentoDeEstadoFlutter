import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/auth.dart';
import 'package:gerenciamento_de_estado/models/cart.dart';
import 'package:gerenciamento_de_estado/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final Auth auth = Provider.of(context, listen: false);

    final msg = ScaffoldMessenger.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              onPressed: () async {
                try {
                  await product.toggleFavorite(
                    auth.token ?? '',
                    auth.uid ?? '',
                  );
                } catch (error) {
                  msg.clearSnackBars();
                  msg.showSnackBar(SnackBar(
                    content: Text(
                      error.toString(),
                    ),
                    duration: const Duration(seconds: 2),
                  ));
                }
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.deepOrange,
              ),
            ),
          ),
          backgroundColor: Colors.black54,
          trailing: IconButton(
            onPressed: () {
              msg.hideCurrentSnackBar();
              msg.showSnackBar(
                SnackBar(
                  content: const Text("Produto Adicionado com sucesso"),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: "DESFAZER",
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      }),
                ),
              );
              cart.addItem(product);
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).highlightColor,
            ),
          ),
        ),
        child: GestureDetector(
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: const AssetImage("assets/images/greyBawx.png"),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
        ),
      ),
    );
  }
}
