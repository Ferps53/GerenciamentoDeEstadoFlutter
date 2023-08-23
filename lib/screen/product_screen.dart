import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/product_list.dart';
import 'package:gerenciamento_de_estado/widget/app_drawer.dart';
import 'package:gerenciamento_de_estado/widget/product_item.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList productList = Provider.of(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text("Gerenciador de Produtos"),
      ),
      body: Padding(
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
    );
  }
}
