import 'package:crud/models/product.dart';
import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'product_form_screen.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final api = ApiService();
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      final data = await api.getList("produtos");
      print('dados recebidos: $data');
      setState(() {
        products = data.map((e) => ProductModel.fromJson(e)).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar produtos: $e")),
      );
    }
    
  }

  Future<void> abrirFormulario({ProductModel? product}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductFormScreen(product: product),
      ),
    );

    if (result == true) {
      load();
    }
  }

  Future<void> excluir(ProductModel p) async {
    final ok = await api.delete("produtos", p.id);
    if (ok) load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Produtos")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => abrirFormulario(),
        child: const Icon(Icons.add),
      ),
      body: products.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, index) {
          final p = products[index];
          return ListTile(
            title: Text("${p.nome} - R\$${p.preco.toStringAsFixed(2)}"),
            subtitle: Text(p.descricao),
            onTap: () => abrirFormulario(product: p),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => excluir(p),
            ),
          );
        },
      ),
    );
  }
}
