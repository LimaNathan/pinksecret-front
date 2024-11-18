// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinksecret_front/src/core/ui/components/custom_spacer.dart';

class NewOrderPage extends StatelessWidget {
  const NewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final colorScheme = Theme.of(context).colorScheme;
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant.withAlpha(40),
          ),
          height: height * .1,
          width: width,
          padding: EdgeInsets.all(width * .015),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .005),
                child: ChipNewOrderButton(
                  label: 'Categoria ${index + 1}',
                  onPressed: () {},
                  icon: Icons.apps_rounded,
                  isSelected: false,
                ),
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant.withAlpha(40),
          ),
          padding: EdgeInsets.all(width * .015),
          width: width,
          height: height * .84,
          child: Card(
            margin: EdgeInsets.all(width * .015),
            child: Padding(
              padding: EdgeInsets.all(width * .015),
              child: Text('data'),
            ),
          ),
        ),
      ],
    );
  }
}

class ChipNewOrderButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final bool isSelected;
  final IconData icon;
  const ChipNewOrderButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * .013,
        vertical: height * .0075,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorScheme.tertiaryContainer,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: colorScheme.onTertiaryContainer,
          ),
          CustomSpacer(),
          Text(
            label,
            style: GoogleFonts.openSans(
              fontSize: 12,
              color: colorScheme.onTertiaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
