import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:pinksecret_front/src/core/interactor/atoms/core_atoms.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';
import 'package:pinksecret_front/src/core/ui/components/custom_spacer.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/home_atoms.dart';
import 'package:pinksecret_front/src/features/home/iteractor/states/home_states.dart';
import 'package:pinksecret_front/src/features/home/ui/components/drawer/drawer_button.dart';


class DrawerNavigationItens extends StatelessWidget {
  const DrawerNavigationItens({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = deviceType.value == DeviceType.mobile;

    final state = context.select(() => homeState.value);
    final customHeight =
        isMobile ? MediaQuery.sizeOf(context).height * .02 : null;
    return Column(
      children: [
        CustomSpacer(),
        CustomDrawerButton(
          label: 'Dashboard',
          icon: Icons.dashboard_rounded,
          isSelected: state is DashboardState,
          selected: toDashboard.call,
        ),
        CustomSpacer(customHeight: customHeight),
        CustomDrawerButton(
          label: 'Estoque',
          icon: Icons.storage_rounded,
          isSelected: state is StorageState,
          selected: toStorageAction.call,
        ),
        CustomSpacer(customHeight: customHeight),
        CustomDrawerButton(
          label: 'Venda',
          icon: Icons.sell,
          isSelected: state is ShopState,
          selected: toShopAction,
        ),
      ],
    );
  }
}
