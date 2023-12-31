import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/product_list.dart';
import 'package:gerenciamento_de_estado/utils/app_routes.dart';
import 'package:gerenciamento_de_estado/widget/app_drawer.dart';
import 'package:gerenciamento_de_estado/widget/product_item.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList productList = Provider.of(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Gerenciar Produtos"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_FORM,
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productList.itemsCount,
            itemBuilder: (context, index) => Column(children: [
              ProductItem(
                product: productList.items[index],
              ),
              const Divider(),
            ]),
          ),
        ),
      ),
    );
  }
}
