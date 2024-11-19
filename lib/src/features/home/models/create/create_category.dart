class CreateCategory {
  String? nome;
  String? descricao;

  CreateCategory({
    this.descricao,
    this.nome,
  });

  CreateCategory.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'descricao': descricao,
      };
}
