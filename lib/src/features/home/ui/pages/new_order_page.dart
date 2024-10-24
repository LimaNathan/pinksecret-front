import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewOrderPage extends StatelessWidget {
  const NewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          Row(
            children: [
              Chip(
                color: MaterialStatePropertyAll<Color>(Colors.red),
                label: Text(
                  'sei la',
                  style: GoogleFonts.openSans(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
