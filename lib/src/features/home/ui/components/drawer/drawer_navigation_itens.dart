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
    final isMobile = deviceType.state == DeviceType.mobile;
    final state = useAtomState(homeState);

    return Column(
      children: [
        CustomSpacer(),
        ..._buildDrawerButtons(context, state, isMobile),
      ],
    );
  }

  List<Widget> _buildDrawerButtons(
      BuildContext context, HomeState state, bool isMobile) {
    final buttons = [
      _DrawerButtonConfig(
        'Dashboard',
        FontAwesomeIcons.chartLine,
        state is DashboardState,
        toDashboard.call,
      ),
      _DrawerButtonConfig(
        'Produtos',
        FontAwesomeIcons.bagShopping,
        state is StorageState,
        toStorageAction.call,
      ),
      _DrawerButtonConfig(
        'Venda',
        FontAwesomeIcons.cartShopping,
        state is ShopState,
        toShopAction.call,
      ),
    ];

    final customHeight =
        isMobile ? MediaQuery.sizeOf(context).height * .02 : null;

    return buttons.map((config) {
      return Column(
        children: [
          CustomDrawerButton(
            label: config.label,
            icon: config.icon,
            isSelected: config.isSelected,
            selected: config.selected,
          ),
          if (customHeight != null) CustomSpacer(customHeight: customHeight),
        ],
      );
    }).toList();
  }
}

class _DrawerButtonConfig {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Function() selected;

  _DrawerButtonConfig(this.label, this.icon, this.isSelected, this.selected);
}
