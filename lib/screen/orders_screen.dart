import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/order_list.dart';
import 'package:gerenciamento_de_estado/widget/app_drawer.dart';
import 'package:gerenciamento_de_estado/widget/order.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: const Text("Meus Pedidos"),
      ),
      body: ListView.builder(
        itemCount: orderList.itemsCount,
        itemBuilder: (context, index) {
          return OrderWidget(order: orderList.items[index]);
        },
      ),
    );
  }
}
