class Category {
  int? id;
  String? nome;
  String? descricao;
  String? dataCriacao;
  String? dataAtualizacao;

  Category({
    this.id,
    this.nome,
    this.descricao,
    this.dataCriacao,
    this.dataAtualizacao,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    dataCriacao = json['dataCriacao'];
    dataAtualizacao = json['dataAtualizacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['descricao'] = descricao;
    data['dataCriacao'] = dataCriacao;
    data['dataAtualizacao'] = dataAtualizacao;
    return data;
  }
}
