import 'package:flutter/material.dart';
import '../../models/client.dart';
import '../../services/api_service.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_button.dart';

class ClientFormScreen extends StatefulWidget {
  final ClientModel? client;

  const ClientFormScreen({super.key, this.client});

  @override
  State<ClientFormScreen> createState() => _ClientFormScreenState();
}

class _ClientFormScreenState extends State<ClientFormScreen> {
  final nome = TextEditingController();
  final sobrenome = TextEditingController();
  final email = TextEditingController();
  final idade = TextEditingController();
  final foto = TextEditingController();

  final api = ApiService();

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      nome.text = widget.client!.nome;
      sobrenome.text = widget.client!.sobrenome;
      email.text = widget.client!.email;
      idade.text = widget.client!.idade.toString();
      foto.text = widget.client!.foto;
    }
  }

  Future<void> salvar() async {
    final data = {
      "nome": nome.text,
      "sobrenome": sobrenome.text,
      "email": email.text,
      "idade": int.parse(idade.text),
      "foto": foto.text,
    };

    bool ok;

    if (widget.client == null) {
      ok = await api.create("clientes", data);
    } else {
      ok = await api.update("clientes", widget.client!.id, data);
    }

    if (!mounted) return;

    if (ok) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao salvar cliente")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.client == null ? "Novo Cliente" : "Editar Cliente"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomInput(controller: nome, label: "Nome"),
            const SizedBox(height: 20),
            CustomInput(controller: sobrenome, label: "Sobrenome"),
            const SizedBox(height: 20),
            CustomInput(controller: email, label: "Email"),
            const SizedBox(height: 20),
            CustomInput(controller: idade, label: "Idade"),
            const SizedBox(height: 20),
            CustomInput(controller: foto, label: "URL da Foto"),
            const SizedBox(height: 20),
            CustomButton(text: "Salvar", onPressed: salvar),
          ],
        ),
      ),
    );
  }
}
