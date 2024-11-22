import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticTile extends StatelessWidget {
  const StatisticTile({
    super.key,
    required this.label,
    required this.primaryInfo,
    this.secondaryInfo,
  });

  final String label;
  final String primaryInfo;
  final String? secondaryInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w100,
          ),
        ),
        RichText(
          text: TextSpan(
            text: primaryInfo,
            style: GoogleFonts.openSans(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.primary,
            ),
            children: [
              TextSpan(
                text: secondaryInfo,
                style: GoogleFonts.openSans(
                  fontSize: 11,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
