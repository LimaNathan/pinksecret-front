import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinksecret_front/src/core/ui/components/custom_spacer.dart';

class TextDrawerButton extends StatelessWidget {
  const TextDrawerButton({
    super.key,
    required this.isSelected,
    required this.colorScheme,
    required this.borderRadius,
    required this.icon,
    required this.label,
  });

  final bool isSelected;
  final ColorScheme colorScheme;
  final BorderRadius borderRadius;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
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
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: !isSelected ? null : colorScheme.tertiary,
          ),
          CustomSpacer(),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                color: !isSelected ? null : colorScheme.tertiary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
