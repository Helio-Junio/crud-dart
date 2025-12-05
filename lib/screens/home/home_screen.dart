import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../clients/clients_list_screen.dart';
import '../products/products_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistema de Controle"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: "Clientes",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ClientsListScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Produtos",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductsListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
