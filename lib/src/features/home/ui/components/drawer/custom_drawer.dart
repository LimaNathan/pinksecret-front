import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/core/interactor/atoms/core_atoms.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';
import 'package:pinksecret_front/src/features/auth/interactor/atoms/auth_atoms.dart';
import 'package:pinksecret_front/src/features/home/ui/components/drawer/drawer_button.dart';
import 'package:pinksecret_front/src/features/home/ui/components/drawer/drawer_header.dart';
import 'package:pinksecret_front/src/features/home/ui/components/drawer/drawer_navigation_itens.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = deviceType.state == DeviceType.mobile;
    final paddingHorizontal = MediaQuery.sizeOf(context).width * 0.02;
    final drawerWidth = MediaQuery.sizeOf(context).width * 0.2;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      width: drawerWidth,
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          const CustomDrawerHeader(),
          const Divider(),
          const DrawerNavigationItens(),
          Spacer(),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).width * 0.02),
      child: CustomDrawerButton(
        icon: Icons.logout,
        label: 'Logout',
        isSelected: false,
        selected: () => _showLogoutDialog(context),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair'),
        content: const Text('Deseja mesmo encerrar a sua sessão?'),
        actions: [
          TextButton(
            onPressed: Modular.to.pop,
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: loggoutAction.call,
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }
}
