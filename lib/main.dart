import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/screen/product_detail_screen.dart';
import 'package:gerenciamento_de_estado/screen/products_overview_screen.dart';
import 'package:gerenciamento_de_estado/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.purple,
        highlightColor: Colors.deepOrange,
        fontFamily: 'Lato',
        useMaterial3: true,
      ),
      home: ProductOverViewScreen(),
      routes: {
        AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
