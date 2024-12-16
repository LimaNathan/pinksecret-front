import 'dart:convert';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinksecret_front/src/core/interactor/atoms/core_atoms.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';
import 'package:pinksecret_front/src/core/ui/components/custom_divider.dart';
import 'package:pinksecret_front/src/core/ui/components/custom_spacer.dart';
import 'package:pinksecret_front/src/core/ui/components/show_custom_loading.dart';
import 'package:pinksecret_front/src/core/ui/components/show_custom_notification.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/product_state.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/product_atoms.dart';
import 'package:pinksecret_front/src/features/home/models/product_model.dart';
import 'package:pinksecret_front/src/features/home/ui/components/dialogs/new_product_dialog.dart';
import 'package:pinksecret_front/src/features/home/ui/components/dialogs/product_details_dialog.dart';
import 'package:pinksecret_front/src/features/home/ui/components/statistic_tile.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> with HookStateMixin {
  @override
  void initState() {
    super.initState();
    fetchProductsPaginatedAction.call((page: 0, size: 6));
  }

  @override
  Widget build(BuildContext context) {
    final deviceT = useAtomState(deviceType);
    final size = MediaQuery.sizeOf(context);

    useAtomState(createProductState).when(
      init: () {},
      loading: (_) => WidgetsBinding.instance
          .addPostFrameCallback((_) => LoadingOverlay.show(context)),
      oneProductLoaded: (state) {
        LoadingOverlay.hide();
        ProductDetailsDialog.show(context: context, product: state.product);
      },
    );
    final productsState = useAtomState(productState)
      ..when(
        init: () {},
        loading: (_) => WidgetsBinding.instance
            .addPostFrameCallback((_) => LoadingOverlay.show(context)),
        loaded: (_) => LoadingOverlay.hide(),
        error: (state) {
          LoadingOverlay.hide();
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => showCustomNotification(
              context,
              message: state.message,
              color: Theme.of(context).colorScheme.error,
            ),
          );
        },
      );
    return productsState.when(
      init: () {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Nenhum produto adicionado. Adicione um produto logo a baixo.'),
              CustomSpacer(),
              FloatingActionButton.extended(
                onPressed: () => NewProductDialog.show(context: context),
                label: Text('+ Novo Produto'),
              ),
            ],
          ),
        );
      },
      loaded: (ProductsLoaded currentState) {
        void nextPage() => ((currentState.page! + 1) < currentState.totalPages!)
            ? fetchProductsPaginatedAction
                .call((page: currentState.page! + 1, size: 6))
            : null;

        void previousPage() => (currentState.page! > 0)
            ? fetchProductsPaginatedAction.call(
                (page: currentState.page! - 1, size: 6),
              )
            : null;
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(10),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => NewProductDialog.show(context: context),
            label: Text('+ Novo Produto'),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * .05,
              horizontal: size.height * .008,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  visible: deviceT != DeviceType.mobile,
                  replacement: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: previousPage,
                  ),
                  child: OutlinedButton(
                    onPressed: previousPage,
                    child: Text('Anterior'),
                  ),
                ),
                Text(
                  'Pág. ${currentState.page! + 1} '
                  'de ${currentState.totalPages}',
                  style: GoogleFonts.inter(),
                ),
                Visibility(
                  visible: deviceT != DeviceType.mobile,
                  replacement: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowRight,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: nextPage,
                  ),
                  child: OutlinedButton(
                    onPressed: nextPage,
                    child: Text('Próxima'),
                  ),
                ),
              ],
            ),
          ),
          body: currentState.products.isEmpty
              ? Center(
                  child: Text(
                      'Nenhum produto adicionado. Adicione um produto logo a baixo.'),
                )
              : ListView(
                  children: [
                    ProductStatistics(currentState: currentState),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: currentState.products.length,
                      itemBuilder: (context, index) =>
                          ProductTile(product: currentState.products[index]),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class ProductStatistics extends StatelessWidget {
  const ProductStatistics({
    super.key,
    required this.currentState,
  });

  final ProductsLoaded currentState;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.all(width * .015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estatísca de Produto',
            style: GoogleFonts.nunito(
              fontSize: 22,
              fontWeight: FontWeight.w300,
            ),
          ),
          Divider(),
          Row(
            children: [
              StatisticTile(
                label: 'Produtos ativos',
                primaryInfo: '${currentState.totalProducts} ',
                secondaryInfo: 'Produtos',
              ),
              CustomDivider(
                height: height * .05,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductTile extends StatelessWidget with HookMixin {
  const ProductTile({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final deviceT = useAtomState(deviceType);

    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    void onTap() {
      fetchProductByIdAction(product.id!);
    }

    return Badge(
      isLabelVisible: product.dataCriacao != null &&
          DateTime.parse(product.dataCriacao!).isAfter(
            DateTime.now().subtract(
              Duration(
                hours: 4,
              ),
            ),
          ),
      largeSize: 30,
      label: Text(
        'Novo',
        style: GoogleFonts.inter(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onTertiaryContainer,
        ),
      ),
      alignment: Alignment.topLeft,
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      child: Container(
        height: height * .1,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onError,
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 0.1,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: height * .005,
          horizontal: width * .005,
        ),
        child: InkWell(
          onTap: deviceT != DeviceType.desktop ? onTap : null,
          child: Row(
            children: [
              ProductTileImage(productModel: product),
              CustomSpacer(),
              SizedBox(
                width: deviceT == DeviceType.mobile ? width * .45 : width * .2,
                child: ProductTileLabel(product: product),
              ),
              Spacer(),
              Visibility(
                visible: deviceT != DeviceType.mobile,
                child: Row(
                  children: [
                    ProductTileItem(
                      label: 'Em estoque',
                      icon: Icon(
                        FontAwesomeIcons.boxOpen,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      content: '${product.quantidadeEstoque ?? 'n/a'}',
                    ),
                    ProductTileItem(
                      label: 'Preço do Produto',
                      content: product.preco?.toStringAsFixed(2) ?? 'n/a',
                      icon: Icon(
                        FontAwesomeIcons.dollarSign,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: deviceT == DeviceType.desktop,
                child: Row(
                  children: [
                    CustomSpacer(),
                    CustomDivider(height: height * .035),
                    Padding(
                      padding: EdgeInsets.only(right: width * .02),
                      child: IconButton(
                        onPressed: onTap,
                        icon: Icon(
                          FontAwesomeIcons.pencil,
                          size: 18,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductTileLabel extends StatelessWidget {
  const ProductTileLabel({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          product.nome ?? 'n/a',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(
          product.descricao ?? 'n/a',
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w200,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class ProductTileImage extends StatelessWidget {
  const ProductTileImage({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * .005,
        vertical: width * .005,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12)),
      width: height * .09,
      height: height * .09,
      child: productModel.imagemProduto == null
          ? Icon(
              FontAwesomeIcons.image,
              color: Theme.of(context).colorScheme.primary,
            )
          : Padding(
              padding: EdgeInsets.all(width * .0055),
              child: Image.memory(
                base64Decode(productModel.imagemProduto!),
                fit: BoxFit.contain,
              ),
            ),
    );
  }
}

class ProductTileItem extends StatelessWidget with HookMixin {
  const ProductTileItem({
    required this.label,
    required this.content,
    required this.icon,
    super.key,
  });

  final String label;
  final String content;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final deviceT = useAtomState(deviceType);

    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    final children = [
      icon,
      CustomSpacer(),
      Text(
        content,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    ];
    return Row(
      children: [
        CustomSpacer(),
        CustomDivider(height: height * .035),
        Container(
          margin: EdgeInsets.symmetric(horizontal: width * .015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: deviceT == DeviceType.desktop,
                child: Text(
                  label,
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(
                width: width * .1,
                child: switch (deviceT) {
                  DeviceType.tablet => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    ),
                  _ => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children),
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
