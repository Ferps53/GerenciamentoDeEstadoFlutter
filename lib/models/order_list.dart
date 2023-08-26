import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/cart_item.dart';
import 'package:gerenciamento_de_estado/utils/url.dart';
import 'package:http/http.dart' as http;

import 'cart.dart';
import 'order.dart';

class OrderList with ChangeNotifier {
  final String _token;
  final String _uid;
  List<Order> _items = [];

  OrderList(this._items, this._token, this._uid);

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return items.length;
  }

  Future<void> loadOrders() async {
    List<Order> items = [];

    ///$uid/$id.json?auth=$token
    final response = await http.get(
      Uri.parse("${UrlList.ORDER}$_uid.json?auth=$_token"),
    );

    if (response.body == 'null') {
      return;
    }

    Map<String, dynamic> data = jsonDecode(response.body);

    print("Token:$_token");
    print("Uid:$_uid");

    print(data);

    data.forEach((orderId, orderData) {
      items.add(
        Order(
          id: orderId,
          date: DateTime.parse(orderData['date']),
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItem(
              id: item['id'],
              productId: item['productId'],
              name: item['name'],
              quantity: item['quantity'],
              price: item['price'],
            );
          }).toList(),
        ),
      );
    });
    _items = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse("${UrlList.ORDER}/$_uid.json?auth=$_token"),
      body: jsonEncode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products': cart.items.values
            .map((cartitem) => {
                  'id': cartitem.id,
                  'productId': cartitem.productId,
                  'name': cartitem.name,
                  'quantity': cartitem.quantity,
                  'price': cartitem.price,
                })
            .toList(),
      }),
    );
    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }
}
