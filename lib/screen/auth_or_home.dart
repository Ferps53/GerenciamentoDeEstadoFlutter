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
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.error != null) {
          return const Center(
            child: Text("Ocorreu um erro"),
          );
        } else {
          return auth.isAuth
              ? const ProductOverViewScreen()
              : const AuthScreen();
        }
      }),
    );
  }
}
