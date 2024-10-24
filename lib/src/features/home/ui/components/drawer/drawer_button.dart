import 'package:flutter/material.dart';
import 'package:pinksecret_front/src/core/interactor/atoms/core_atoms.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';
import 'package:pinksecret_front/src/features/home/ui/components/drawer/icon_drawer_button.dart';
import 'package:pinksecret_front/src/features/home/ui/components/drawer/text_drawer_button.dart';

class CustomDrawerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Function() selected;
  const CustomDrawerButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = deviceType.value == DeviceType.mobile;
    final borderRadius = BorderRadius.circular(8);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      splashColor: colorScheme.tertiaryContainer,
      borderRadius: borderRadius,
      onTap: selected,
      child: Visibility(
        visible: !isMobile,
        replacement: IconDrawerButton(
          isSelected: isSelected,
          colorScheme: colorScheme,
          borderRadius: borderRadius,
          icon: icon,
        ),
        child: TextDrawerButton(
          isSelected: isSelected,
          colorScheme: colorScheme,
          borderRadius: borderRadius,
          icon: icon,
          label: label,
        ),
      ),
    );
  }
}
