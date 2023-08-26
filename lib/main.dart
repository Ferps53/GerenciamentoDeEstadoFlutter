import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/auth.dart';
import 'package:gerenciamento_de_estado/models/order_list.dart';
import 'package:gerenciamento_de_estado/models/product_list.dart';
import 'package:gerenciamento_de_estado/screen/auth_or_home.dart';
import 'package:gerenciamento_de_estado/screen/cart_screen.dart';
import 'package:gerenciamento_de_estado/screen/orders_screen.dart';
import 'package:gerenciamento_de_estado/screen/product_detail_screen.dart';
import 'package:gerenciamento_de_estado/screen/product_form_screen.dart';
import 'package:gerenciamento_de_estado/screen/product_screen.dart';
import 'package:gerenciamento_de_estado/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'models/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList([], ''),
          update: (context, auth, previous) {
            return ProductList(
              previous?.items ?? [],
              auth.token ?? "",
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.purple,
          highlightColor: Colors.deepOrange,
          fontFamily: 'Lato',
          useMaterial3: true,
        ),
        routes: {
          AppRoutes.AUTH: (context) => const AuthOrHome(),
          AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailScreen(),
          AppRoutes.CART: (context) => const CartScreen(),
          AppRoutes.ORDERS: (context) => const OrdersScreen(),
          AppRoutes.PRODUCT_MANAGER: (context) => const ProductScreen(),
          AppRoutes.PRODUCT_FORM: (context) => const ProductFormScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
