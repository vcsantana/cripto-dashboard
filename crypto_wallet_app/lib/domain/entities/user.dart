class User {
  final String nome;
  final String descricao;
  final String imagem;

  User({
    required this.nome,
    required this.descricao,
    required this.imagem,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nome: json['nome'] ?? '',
      descricao: json['descricao'] ?? '',
      imagem: json['imagem'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'imagem': imagem,
    };
  }
}
