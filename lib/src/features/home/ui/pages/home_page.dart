import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:pinksecret_front/src/core/interactor/atoms/core_atoms.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';
import 'package:pinksecret_front/src/core/ui/components/custom_appbar.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/home_atoms.dart';
import 'package:pinksecret_front/src/features/home/ui/components/drawer/custom_drawer.dart';
import 'package:pinksecret_front/src/features/home/ui/pages/new_order_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final state = context.select(() => homeState.value);
    final isMobile = deviceType.value == DeviceType.mobile;
    return Material(
      child: Row(
        children: [
          CustomDrawer(),
          Container(
            height: height,
            width: width * 0.001,
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
          Flexible(
            flex: 5,
            child: Scaffold(
              appBar: isMobile
                  ? AppBar(
                      title: Text('Pinksecret'),
                    )
                  : CustomAppbar(
                      size: height * .06,
                    ),
              body: state.when(
                init: Container.new,
                dashboard: (p0) {
                  return Center(
                    child: Text('Funcionalidade em desenvolvimento'),
                  );
                },
                shop: (p0) {
                  return NewOrderPage();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
