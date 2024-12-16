import 'dart:convert';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinksecret_front/src/core/interactor/atoms/core_atoms.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';
import 'package:pinksecret_front/src/core/service/image_picker.dart';
import 'package:pinksecret_front/src/core/ui/components/custom_spacer.dart';
import 'package:pinksecret_front/src/core/ui/components/loading_component.dart';
import 'package:pinksecret_front/src/core/ui/components/show_custom_notification.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/category_atoms.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/product_atoms.dart';
import 'package:pinksecret_front/src/features/home/models/category_model.dart';
import 'package:pinksecret_front/src/features/home/models/create/create_category.dart';
import 'package:pinksecret_front/src/features/home/models/create/create_product.dart';
import 'package:pinksecret_front/src/shared/utils/constants/image_constants.dart';

class NewProductDialog {
  NewProductDialog._();

  static Future<void> show({required BuildContext context}) async {
    final navContext = context;
    final size = MediaQuery.sizeOf(navContext);
    final priceController = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
    );

    final child = _DialogContent(
      size: size,
      priceController: priceController,
    );

    if (deviceType.state == DeviceType.desktop) {
      await showDialog(
        context: navContext,
        builder: (context) => _Dialog(
          size: size,
          child: child,
        ),
      );
    } else {
      await showModalBottomSheet(
        context: navContext,
        showDragHandle: true,
        constraints: BoxConstraints(minHeight: size.height * .7),
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

  Widget _buildTitle(BuildContext context, {String? title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text(
            title ?? 'Novo Produto',
            style:
                GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Spacer(),
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
  final Size size;
  final MoneyMaskedTextController priceController;

  const _DialogContent({required this.size, required this.priceController});

  @override
  State<_DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<_DialogContent> with HookStateMixin {
  static Uint8List? image;
  static CategoriaModel? selectedCategory;
  final productNameEC = TextEditingController();
  final descriptionEC = TextEditingController();
  final quantityEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCategoriesAction();
  }

  @override
  void dispose() {
    super.dispose();
    selectedCategory = null;
  }

  @override
  Widget build(BuildContext context) {
    final prodState = useAtomState(createProductState)
      ..when(
        init: () {},
        created: Modular.to.pop,
        error: (state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showCustomNotification(context, message: state.message);
          });

          resetCreateProductStateAction();
          resetProductStateAction();
          Modular.to.pop();
        },
      );

    return prodState.when(
      loading: (_) => LoadingWithTypingEffect(
        imagePath: ImageConstants.logoResumida,
        imageSize: widget.size.width * .3,
      ),
      init: () => _buildForm(context),
      error: (state) => Container(),
    );
  }

  Widget _buildForm(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildImagePicker(),
        CustomSpacer(customHeight: widget.size.height * 0.025),
        _buildDetailsSection(context),
        CustomSpacer(customHeight: widget.size.height * 0.025),
        ElevatedButton(
          onPressed: _createProduct,
          child: Text('Criar novo produto'),
        ),
      ],
    );
  }

  void _createProduct() {
    if (selectedCategory == null) {
      showCustomNotification(context, message: 'Selecione alguma categoria.');
    }

    if (productNameEC.text.isEmpty) {
      showCustomNotification(context,
          message:
              'Pelo menos o nome do produto e a categoria devem ser preenchidos.');
    }

    if (widget.priceController.text == '0,00') {
      showCustomNotification(context,
          message: 'O preço do produto deve ser informado.');
    }

    createProductAction(
      CreateProduct(
        nome: productNameEC.text,
        descricao: descriptionEC.text,
        preco: double.tryParse(widget.priceController.text
            .replaceAll('.', '')
            .replaceAll(',', '.')),
        quantidade: quantityEC.text.isEmpty ? 1 : int.tryParse(quantityEC.text),
        categoria: selectedCategory!.id,
        imagemProduto: image != null ? base64Encode(image!) : null,
      ),
    );

    image = null;
  }

  Widget _buildImagePicker() {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () async {
          image = await ImagePicker.pickImage();
          setState(() {});
        },
        child: SizedBox(
          height: widget.size.height * 0.2,
          child: Center(
            child:
                image != null ? Image.memory(image!) : _buildImagePlaceholder(),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Icon(FontAwesomeIcons.folderPlus, size: 40, color: Colors.grey);
  }

  Widget _buildDetailsSection(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final categoryNameController = TextEditingController();
    final categoryDescriptionController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTextField(productNameEC, 'Nome do produto',
            'Ex.: Calcinha de renda, sutiã sem bojo...'),
        CustomSpacer(customHeight: widget.size.height * 0.025),
        _buildTextField(descriptionEC, 'Descrição do produto',
            'Breve descrição do produto (opcional)'),
        CustomSpacer(customHeight: widget.size.height * 0.025),
        _buildCategoryDropdown(),
        CustomSpacer(customHeight: widget.size.height * 0.015),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                titlePadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Nova Categoria',
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: Modular.to.pop,
                        icon: Icon(
                          FontAwesomeIcons.xmark,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField(
                      categoryNameController,
                      'Nome da categoria',
                      'O nome que será exibido ao selecionar uma categoria.',
                    ),
                    CustomSpacer(),
                    _buildTextField(
                      categoryDescriptionController,
                      'Descrição',
                      'Breve descrição da categoria.',
                    ),
                    CustomSpacer(
                      customHeight: size.height * .025,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Modular.to.pop();
                          if (categoryNameController.text.isEmpty) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showCustomNotification(context,
                                  message:
                                      'O nome da categoria deve ser preenchido.');
                            });
                          } else {
                            createCategoryAction(
                              CreateCategory(
                                descricao: categoryDescriptionController.text,
                                nome: categoryNameController.text,
                              ),
                            );
                          }
                        },
                        child: Text('Criar nova categoria')),
                  ],
                ),
              ),
            );
          },
          child: Text('Nova Categoria'),
        ),
        CustomSpacer(customHeight: widget.size.height * 0.025),
        _buildNumberFields(),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String hint) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
    );
  }

  Widget _buildNumberField(String label, String hint,
      {String? prefixText,
      List<TextInputFormatter>? inputFormatters,
      TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixText: prefixText,
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    final catState = useAtomState(categoryState)
      ..when(
        init: () {},
        error: (state) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => showCustomNotification(context, message: state.message));

          resetCategoryStateAction();
          fetchCategoriesAction();
        },
      );
    return catState.when(
      init: () => Center(child: const CircularProgressIndicator()),
      error: (state) => Text(
        'Houve um erro ao carregar as categorias.',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      loaded: (state) {
        final categories = state.categories;
        return categories.isEmpty
            ? Text(
                'Nenhuma categoria disponível, crie uma ou atualize a página.')
            : DropdownButtonFormField<CategoriaModel>(
                hint: Text(
                  'Selecione uma categoria.',
                  style: GoogleFonts.inter(color: Colors.black54),
                ),
                value: selectedCategory,
                onChanged: (categoria) =>
                    setState(() => selectedCategory = categoria),
                items: categories
                    .map((category) => DropdownMenuItem<CategoriaModel>(
                          value: category,
                          child: Text(category.nome ?? 'n/a',
                              style: GoogleFonts.inter()),
                        ))
                    .toList(),
              );
      },
    );
  }

  Widget _buildNumberFields() {
    return Row(
      children: [
        Expanded(
          child: _buildNumberField('Quantidade do produto', '0',
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: quantityEC),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildNumberField('Preço do produto (unidade)', '0,00',
              prefixText: 'R\$ ', controller: widget.priceController),
        ),
      ],
    );
  }
}
