import 'package:flutter/material.dart';
import '../../models/client.dart';
import '../../services/api_service.dart';
import 'client_form_screen.dart';

class ClientsListScreen extends StatefulWidget {
  const ClientsListScreen({super.key});

  @override
  State<ClientsListScreen> createState() => _ClientsListScreenState();
}

class _ClientsListScreenState extends State<ClientsListScreen> {
  final api = ApiService();
  List<ClientModel> clients = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      final data = await api.getList("clientes");
    setState(() {
      clients = data.map((e) => ClientModel.fromJson(e)).toList();
    });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar clientes: $e")),
      );
    }
    
  }

  Future<void> abrirFormulario({ClientModel? client}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClientFormScreen(client: client),
      ),
    );

    if (result == true) {
      load();
    }
  }

  Future<void> excluir(ClientModel c) async {
    final ok = await api.delete("clientes", c.id);
    if (ok) load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Clientes")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => abrirFormulario(),
        child: const Icon(Icons.add),
      ),
      body: clients.isEmpty
      ? const Center(child: CircularProgressIndicator())
      :ListView.builder(
        itemCount: clients.length,
        itemBuilder: (_, index) {
          final c = clients[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(c.foto)),
            title: Text("${c.nome} ${c.sobrenome}"),
            subtitle: Text(c.email),
            onTap: () => abrirFormulario(client: c),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => excluir(c),
            ),
          );
        },
      ),
    );
  }
}
