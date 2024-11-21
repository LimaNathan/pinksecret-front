import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:pinksecret_front/src/core/ui/components/show_custom_loading.dart';
import 'package:pinksecret_front/src/core/ui/components/show_custom_notification.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/category_atoms.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/product_atoms.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> with HookStateMixin {
  @override
  void initState() {
    super.initState();
    fetchCategoriesAction.call();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = useAtomState(categoryState).when(
      init: () {},
      loading: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          LoadingOverlay.show(context);
        });
      },
      loaded: (_) {
        LoadingOverlay.hide();
        fetchProductsAction.call();
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
      body: Center(
        child: Text('Lista de todos os produsto'),
      ),
    );
  }
}
