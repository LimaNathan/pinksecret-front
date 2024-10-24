import 'package:flutter/material.dart';
import 'package:pinksecret_front/src/core/interactor/atoms/core_atoms.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';
import 'package:pinksecret_front/src/features/home/ui/components/drawer/drawer_button.dart';
import 'package:pinksecret_front/src/features/home/ui/components/drawer/drawer_header.dart';
import 'package:pinksecret_front/src/features/home/ui/components/drawer/drawer_navigation_itens.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = deviceType.value == DeviceType.mobile;

    return Material(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.sizeOf(context).width * .02,
              right: MediaQuery.sizeOf(context).width * .01,
            ),
            width: MediaQuery.sizeOf(context).width * .2,
            child: Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                CustomDrawerHeader(),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Divider(),
                ),
                DrawerNavigationItens(),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.sizeOf(context).width * .02),
                  child: Column(
                    children: [
                      CustomDrawerButton(
                        icon: Icons.logout,
                        label: 'Logout',
                        isSelected: false,
                        selected: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width * 0.001,
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
          Flexible(
            flex: 5,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: Text('Pinksecret'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



