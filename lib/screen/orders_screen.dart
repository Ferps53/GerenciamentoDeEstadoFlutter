import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/order_list.dart';
import 'package:gerenciamento_de_estado/widget/app_drawer.dart';
import 'package:gerenciamento_de_estado/widget/order.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = true;

  Future<void> _refreshOrders(BuildContext context) {
    return Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders().then((value) {
      setState(() => _isLoading = false);
    });
  }

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
      body: RefreshIndicator(
        onRefresh: () => _refreshOrders(context),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: orderList.itemsCount,
                itemBuilder: (context, index) {
                  return OrderWidget(order: orderList.items[index]);
                },
              ),
      ),
    );
  }
}
