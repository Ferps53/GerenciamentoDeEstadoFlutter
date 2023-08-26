import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/auth.dart';
import 'package:gerenciamento_de_estado/screen/auth_screen.dart';
import 'package:gerenciamento_de_estado/screen/products_overview_screen.dart';
import 'package:provider/provider.dart';

class AuthOrHome extends StatelessWidget {
  const AuthOrHome({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth ? const ProductOverViewScreen() : const AuthScreen();
  }
}
