import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinksecret_front/src/core/interactor/atoms/core_atoms.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';
import 'package:pinksecret_front/src/core/ui/components/custom_spacer.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/home_atoms.dart';
import 'package:pinksecret_front/src/features/home/iteractor/states/home_state.dart';
import 'package:pinksecret_front/src/features/home/ui/components/drawer/drawer_button.dart';

class DrawerNavigationItens extends StatelessWidget with HookMixin {
  const DrawerNavigationItens({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceT = useAtomState(deviceType);

    final state = useAtomState(homeState);
    final customHeight = deviceT == DeviceType.mobile
        ? MediaQuery.sizeOf(context).height * .02
        : null;

    return Column(
      children: [
        CustomSpacer(),
        CustomDrawerButton(
          label: 'Dashboard',
          icon: FontAwesomeIcons.chartLine,
          isSelected: state is DashboardState,
          selected: toDashboard.call,
        ),
        CustomSpacer(customHeight: customHeight),
        CustomDrawerButton(
          label: 'Produtos',
          icon: FontAwesomeIcons.bagShopping,
          isSelected: state is StorageState,
          selected: toStorageAction.call,
        ),
        CustomSpacer(customHeight: customHeight),
        CustomDrawerButton(
          label: 'Venda',
          icon: FontAwesomeIcons.cartShopping,
          isSelected: state is ShopState,
          selected: toShopAction.call,
        ),
      ],
    );
  }
}
