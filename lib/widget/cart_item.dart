import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({required this.cartItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
