import 'package:flutter/material.dart';

class IconDrawerButton extends StatelessWidget {
  const IconDrawerButton({
    super.key,
    required this.isSelected,
    required this.colorScheme,
    required this.borderRadius,
    required this.icon,
  });

  final bool isSelected;
  final ColorScheme colorScheme;
  final BorderRadius borderRadius;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, right: 15, left: 15, top: 10),
      decoration: BoxDecoration(
        boxShadow: !isSelected
            ? null
            : [
                BoxShadow(
                  spreadRadius: 10,
                  blurRadius: 25,
                  color: colorScheme.surfaceTint.withOpacity(
                    0.1,
                  ),
                ),
              ],
        borderRadius: borderRadius,
        border: isSelected
            ? BorderDirectional(
                bottom: BorderSide(
                  color: colorScheme.tertiary,
                  width: 4,
                ),
              )
            : null,
      ),
      child: Icon(
        icon,
        size: 16,
        color: !isSelected ? null : colorScheme.tertiary,
      ),
    );
  }
}
