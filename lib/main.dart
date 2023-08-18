import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/screen/products_overview_screen.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Colors.blue,
        useMaterial3: true,
      ),
      home: ProductOverViewScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
