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
import 'package:pinksecret_front/src/features/auth/interactor/states/category_state.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/category_atoms.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/product_atoms.dart';
import 'package:pinksecret_front/src/features/home/models/category_model.dart';
import 'package:pinksecret_front/src/features/home/models/create/create_product.dart';
import 'package:pinksecret_front/src/shared/utils/constants/image_constants.dart';
import 'package:pinksecret_front/src/shared/utils/constants/nav_key.dart';

class NewProductDialog {
  NewProductDialog._();

  static Future<void> show({BuildContext? context}) async {
    final navContext = context ?? NavKey.navKey.currentState!.context;
    final size = MediaQuery.sizeOf(navContext);
    final priceController = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
    );

    final child = _DialogContent(
      size: size,
      priceController: priceController,
    );

    deviceType.state == DeviceType.desktop
        ? await showDialog(
            context: navContext,
            builder: (context) => AlertDialog(
                  scrollable: true,
                  titlePadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.01,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: _buildTitle(context),
                  content: child,
                ))
        : await showModalBottomSheet(
            context: navContext,
            showDragHandle: true,
            constraints: BoxConstraints(minHeight: size.height * .7),
            builder: (context) => Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02,
                vertical: size.height * 0.01,
              ),
              child: SingleChildScrollView(
                child: child,
              ),
            ),
          );
  }

  static Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text(
            'Novo Produto',
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
    );
  }
}

class _DialogContent extends StatefulWidget {
  final Size size;
  final MoneyMaskedTextController priceController;

  const _DialogContent({
    required this.size,
    required this.priceController,
  });

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
    final catState = useAtomState(categoryState);
    final prodState = useAtomState(productState)
      ..when(
        init: () {},
        created: Modular.to.pop,
        error: (state) {
          Modular.to.pop();

          WidgetsBinding.instance.addPostFrameCallback(
              (_) => showCustomNotification(context, message: state.message));
        },
      );

    return prodState.when(
      loading: (_) => LoadingWithTypingEffect(
        imagePath: ImageConstants.logoResumida,
        imageSize: widget.size.width * .3,
      ),
      init: () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImagePicker(),
          CustomSpacer(customHeight: widget.size.height * 0.025),
          _buildDetailsSection(context, catState),
          CustomSpacer(customHeight: widget.size.height * 0.025),
          ElevatedButton(
            onPressed: () {
              createProductAction(CreateProduct(
                nome: productNameEC.text,
                descricao: descriptionEC.text,
                preco: double.parse(widget.priceController.text
                    .replaceAll('.', '')
                    .replaceAll(',', '.')),
                quantidade: int.tryParse(quantityEC.text),
                categoria: selectedCategory!.id,
                imagemProduto: image != null ? base64Encode(image!) : null,
              ));
              Modular.to.pop();
              image = null;
            },
            child: Text('Criar novo produto'),
          )
        ],
      ),
    );
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
            child: image != null
                ? Image.memory(image!)
                : Icon(
                    FontAwesomeIcons.folderPlus,
                    size: 40,
                    color: Colors.grey,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsSection(
      BuildContext context, CategoryState categoryState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          controller: productNameEC,
          label: 'Nome do produto',
          hint: 'Ex.: Calcinha de renda, sutiã sem bojo...',
        ),
        CustomSpacer(customHeight: widget.size.height * 0.025),
        _buildTextField(
          controller: descriptionEC,
          label: 'Descrição do produto',
          hint: 'Breve descrição do produto (opcional)',
        ),
        CustomSpacer(customHeight: widget.size.height * 0.025),
        categoryState.when(
          init: () => const CircularProgressIndicator(),
          loaded: (state) {
            final categories = state.categories;
            return Visibility(
              visible: categories.isNotEmpty,
              child: DropdownButtonFormField<CategoriaModel>(
                value: selectedCategory,
                onChanged: (newValue) {
                  selectedCategory = newValue!;
                },
                items: categories.map((category) {
                  return DropdownMenuItem<CategoriaModel>(
                    value: category,
                    child: Text(category.nome ?? 'n/a'),
                  );
                }).toList(),
                decoration: InputDecoration(
                  helperText: 'Selecione uma categoria',
                  border: OutlineInputBorder(),
                ),
              ),
            );
          },
          error: (state) => Text(
            'Erro: ${state.message}',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
        CustomSpacer(customHeight: widget.size.height * 0.025),
        Row(
          children: [
            Expanded(
              child: _buildNumberField(
                label: 'Quantidade do produto',
                hint: '0',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: quantityEC,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildNumberField(
                label: 'Preço do produto (unidade)',
                hint: '0,00',
                prefixText: 'R\$ ',
                controller: widget.priceController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(
      {required String label,
      required String hint,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        helperText: label,
        hintText: hint,
      ),
    );
  }

  Widget _buildNumberField({
    required String label,
    required String hint,
    String? prefixText,
    List<TextInputFormatter>? inputFormatters,
    TextEditingController? controller,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        helperText: label,
        hintText: hint,
        prefixText: prefixText,
      ),
    );
  }
}
