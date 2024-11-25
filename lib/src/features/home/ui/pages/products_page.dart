import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinksecret_front/src/core/ui/components/custom_divider.dart';
import 'package:pinksecret_front/src/core/ui/components/custom_spacer.dart';
import 'package:pinksecret_front/src/core/ui/components/show_custom_loading.dart';
import 'package:pinksecret_front/src/core/ui/components/show_custom_notification.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/product_state.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/product_atoms.dart';
import 'package:pinksecret_front/src/features/home/models/product_model.dart';
import 'package:pinksecret_front/src/features/home/ui/components/dialogs/new_product_dialog.dart';
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
    fetchProductsPaginatedAction.call((page: 0, size: 10));
  }

  @override
  Widget build(BuildContext context) {
    final productsState = useAtomState(productState)
      ..when(
        init: () {},
        loading: (_) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            LoadingOverlay.show(context);
          });
        },
        loaded: (_) {
          LoadingOverlay.hide();
        },
        error: (state) {
          LoadingOverlay.hide();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showCustomNotification(
              context,
              message: state.message,
              color: Theme.of(context).colorScheme.error,
            );
          });
        },
      );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(10),
      body: productsState.when(
        init: () => null,
        loaded: (ProductsLoaded currentState) {
          return Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton.icon(
                  icon: Icon(FontAwesomeIcons.plus, size: 12),
                  label: Text(
                    'Novo produto',
                    textAlign: TextAlign.center,
                  ),
                  onPressed: NewProductDialog.show,
                ),
              ),
              ProductStatistics(currentState: currentState),
              ListView.builder(
                shrinkWrap: true,
                itemCount: currentState.products.length,
                itemBuilder: (context, index) {
                  return ProductTile(
                    product: currentState.products[index],
                  );
                },
              ),
            ],
          );
        },
      ),
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

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      height: height * .1,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onError,
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 0.1,
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: height * .005,
        horizontal: width * .005,
      ),
      child: Row(
        children: [
          ProductTileImage(productModel: product),
          CustomSpacer(),
          ProductTileLabel(product: product),
          Spacer(),
          ProductTileItem(
            label: 'Em estoque',
            icon: Icon(
              FontAwesomeIcons.boxOpen,
              size: 14,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            content: '${product.quantidadeEstoque ?? 'n/a'}',
          ),
          ProductTileItem(
            label: 'Preço do Produto',
            content: product.preco?.toStringAsFixed(2) ?? 'n/a',
            icon: Icon(
              FontAwesomeIcons.dollarSign,
              size: 14,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          CustomSpacer(),
          CustomDivider(height: height * .035),
          Padding(
            padding: EdgeInsets.only(right: width * .02),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.pencil,
                size: 18,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ],
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
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        Text(
          product.descricao ?? 'n/a',
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w200,
            color: Theme.of(context).colorScheme.onBackground,
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
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12)),
      width: height * .09,
      height: height * .09,
      child: Icon(FontAwesomeIcons.image),
    );
  }
}

class ProductTileItem extends StatelessWidget {
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
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
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
              Text(
                label,
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Row(
                children: [
                  icon,
                  CustomSpacer(),
                  Text(
                    content,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
