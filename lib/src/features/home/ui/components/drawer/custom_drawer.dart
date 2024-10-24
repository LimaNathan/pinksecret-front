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
    final isMobile = deviceType.value == DeviceType.mobile;

    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.sizeOf(context).width * .02,
        right: MediaQuery.sizeOf(context).width * .01,
      ),
      width: MediaQuery.sizeOf(context).width * .2,
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          CustomDrawerHeader(),
          Padding(
            padding: EdgeInsets.zero,
            child: Divider(),
          ),
          DrawerNavigationItens(),
          Spacer(),
          Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.sizeOf(context).width * .02),
            child: Column(
              children: [
                CustomDrawerButton(
                  icon: Icons.logout,
                  label: 'Logout',
                  isSelected: false,
                  selected: () {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Sair'),
                        content: Text('Deseja mesmo encerrar a sua sessão?'),
                        actions: [
                          TextButton(
                            onPressed: Modular.to.pop,
                            child: Text('Não'),
                          ),
                          TextButton(
                            onPressed: loggoutAction.call,
                            child: Text('Sim'),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
