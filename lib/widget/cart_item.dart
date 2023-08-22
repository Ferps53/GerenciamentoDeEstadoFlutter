import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/cart.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({required this.cartItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItem.productId);
      },
      background: Container(
        color: Theme.of(context).colorScheme.error,
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text("${cartItem.price}"),
              ),
            ),
          ),
          title: Text(cartItem.name),
          subtitle: Text("Total: R\$${cartItem.price * cartItem.quantity}"),
          trailing: Text("${cartItem.quantity}x"),
        ),
      ),
    );
  }
}
