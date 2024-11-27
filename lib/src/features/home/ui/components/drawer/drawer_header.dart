import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinksecret_front/src/core/interactor/atoms/core_atoms.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';
import 'package:pinksecret_front/src/shared/utils/constants/image_constants.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = deviceType.state == DeviceType.mobile;
    final logoHeight = MediaQuery.sizeOf(context).height * 0.09;

    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(8.0), // Padding para um melhor espaçamento
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstants.logoResumida,
              height: logoHeight,
            ),
            if (!isMobile)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Pinksecret',
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
