import 'package:pinksecret_front/src/features/home/models/category_model.dart';

class ProductModel {
  int? id;
  String? nome;
  String? descricao;
  double? preco;
  int? quantidadeEstoque;
  CategoriaModel? categoria;
  String? imagemProduto;
  String? dataCriacao;
  String? dataAtualizacao;

  ProductModel(
      {this.id,
      this.nome,
      this.descricao,
      this.preco,
      this.quantidadeEstoque,
      this.categoria,
      this.imagemProduto,
      this.dataCriacao,
      this.dataAtualizacao});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    preco = json['preco'];
    quantidadeEstoque = json['quantidadeEstoque'];
    categoria = json['categoria'] != null
        ? CategoriaModel.fromJson(json['categoria'])
        : null;
    imagemProduto = json['imagemProduto'];
    dataCriacao = json['dataCriacao'];
    dataAtualizacao = json['dataAtualizacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['descricao'] = descricao;
    data['preco'] = preco;
    data['quantidadeEstoque'] = quantidadeEstoque;
    if (categoria != null) {
      data['categoria'] = categoria!.toJson();
    }
    data['imagemProduto'] = imagemProduto;
    data['dataCriacao'] = dataCriacao;
    data['dataAtualizacao'] = dataAtualizacao;
    return data;
  }
}
