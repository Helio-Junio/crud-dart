class ClientModel {
  final int id;
  final String nome;
  final String sobrenome;
  final String email;
  final int idade;
  final String foto;

  ClientModel({
    required this.id,
    required this.nome,
    required this.sobrenome,
    required this.email,
    required this.idade,
    required this.foto,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      nome: json['nome'],
      sobrenome: json['sobrenome'],
      email: json['email'],
      idade: json['idade'],
      foto: json['foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'idade': idade,
      'foto': foto,
    };
  }
}
