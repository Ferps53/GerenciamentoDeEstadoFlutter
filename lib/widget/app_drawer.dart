import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/auth.dart';
import 'package:gerenciamento_de_estado/utils/app_routes.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            title: const Text("Bem vindo Usuário!"),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Loja"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.AUTH,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Pedidos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.ORDERS,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Gerenciador de Produtos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.PRODUCT_MANAGER,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Sair"),
            onTap: () {
              Provider.of<Auth>(
                context,
                listen: false,
              ).signOut();
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.AUTH,
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
