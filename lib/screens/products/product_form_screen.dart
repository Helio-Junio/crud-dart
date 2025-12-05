import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../services/api_service.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_button.dart';

class ProductFormScreen extends StatefulWidget {
  final ProductModel? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final nome = TextEditingController();
  final descricao = TextEditingController();
  final preco = TextEditingController();

  final api = ApiService();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nome.text = widget.product!.nome;
      descricao.text = widget.product!.descricao;
      preco.text = widget.product!.preco.toString();
    }
  }

  Future<void> salvar() async {
    final data = {
      "nome": nome.text,
      "descricao": descricao.text,
      "preco": double.parse(preco.text),
      "data_atualizado": DateTime.now().toIso8601String(),
    };

    bool ok;

    if (widget.product == null) {
      ok = await api.create("produtos", data);
    } else {
      ok = await api.update("produtos", widget.product!.id, data);
    }

    if (!mounted) return;

    if (ok) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Erro ao salvar produto")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.product == null ? "Novo Produto" : "Editar Produto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomInput(controller: nome, label: "Nome"),
            const SizedBox(height: 20),
            CustomInput(controller: descricao, label: "Descrição"),
            const SizedBox(height: 20),
            CustomInput(controller: preco, label: "Preço"),
            const SizedBox(height: 20),
            CustomButton(text: "Salvar", onPressed: salvar),
          ],
        ),
      ),
    );
  }
}
