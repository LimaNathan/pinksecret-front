import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinksecret_front/src/core/interactor/atoms/core_atoms.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/product_atoms.dart';
import 'package:pinksecret_front/src/features/home/models/create/create_product.dart';
import 'package:pinksecret_front/src/features/home/models/product_model.dart';

class ProductDetailsDialog {
  ProductDetailsDialog._();

  static Future<void> show({
    required BuildContext context,
    required ProductModel product,
  }) async {
    final size = MediaQuery.of(context).size;

    final child = _DialogContent(product: product);

    if (deviceType.state == DeviceType.desktop) {
      await showDialog(
        context: context,
        builder: (context) => _Dialog(size: size, child: child),
        barrierDismissible: true,
      );
    } else {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        constraints: BoxConstraints(minHeight: size.height * 0.7),
        builder: (context) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.02,
            vertical: size.height * 0.01,
          ),
          child: SingleChildScrollView(child: child),
        ),
      );
    }
  }
}

class _Dialog extends StatelessWidget {
  final Size size;
  final Widget child;

  const _Dialog({required this.size, required this.child});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
        vertical: size.height * 0.01,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: _buildTitle(context),
      content: child,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text(
            'Detalhes do Produto',
            style:
                GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          IconButton(
            onPressed: Modular.to.pop,
            icon: Icon(
              FontAwesomeIcons.xmark,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogContent extends StatefulWidget {
  final ProductModel product;

  const _DialogContent({required this.product});

  @override
  State<_DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<_DialogContent> {
  late TextEditingController nomeController;
  late TextEditingController descricaoController;
  late TextEditingController precoController;
  late TextEditingController quantidadeEstoqueController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.product.nome);
    descricaoController = TextEditingController(text: widget.product.descricao);
    precoController =
        TextEditingController(text: widget.product.preco?.toString());
    quantidadeEstoqueController = TextEditingController(
        text: widget.product.quantidadeEstoque?.toString());
  }

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();
    precoController.dispose();
    quantidadeEstoqueController.dispose();

    resetCreateProductStateAction();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.product.imagemProduto != null)
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.memory(
                base64Decode(widget.product.imagemProduto!),
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
        const SizedBox(height: 20),
        _buildTextField(label: 'Nome', controller: nomeController),
        const SizedBox(height: 10),
        _buildTextField(
            label: 'Descrição', controller: descricaoController, maxLines: 3),
        const SizedBox(height: 10),
        _buildTextField(
            label: 'Preço',
            controller: precoController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 10),
        _buildTextField(
          label: 'Quantidade em Estoque',
          controller: quantidadeEstoqueController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton.icon(
            onPressed: _saveChanges,
            icon: const Icon(FontAwesomeIcons.floppyDisk),
            label: const Text('Salvar Alterações'),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _saveChanges() {
    final updatedProduct = CreateProduct(
      nome: nomeController.text,
      descricao: descricaoController.text,
      preco: double.tryParse(precoController.text),
      quantidade: int.tryParse(quantidadeEstoqueController.text),
      categoria: widget.product.categoria!.id!,
      imagemProduto: widget.product.imagemProduto,
    );

    updateProductAction(updatedProduct, widget.product.id!);
    // Salve o produto atualizado usando sua lógica de backend ou estado global.
    Modular.to.pop(updatedProduct);
  }
}
