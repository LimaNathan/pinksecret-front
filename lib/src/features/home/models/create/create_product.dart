class CreateProduct {
  String? nome;
  String? descricao;
  double? preco;
  int? quantidade;
  int? categoria;
  String? imagemProduto;

  CreateProduct({
    this.nome,
    this.descricao,
    this.preco,
    this.quantidade,
    this.categoria,
    this.imagemProduto,
  });

  CreateProduct.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    descricao = json['descricao'];
    preco = json['preco'];
    quantidade = json['quantidade'];
    categoria = json['categoria'];
    imagemProduto = json['imagemProduto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['descricao'] = descricao;
    data['preco'] = preco;
    data['quantidade'] = quantidade;
    data['categoria'] = categoria;
    data['imagemProduto'] = imagemProduto;
    return data;
  }
}
