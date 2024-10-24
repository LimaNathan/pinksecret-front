import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinksecret_front/src/core/interactor/atoms/core_atoms.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';
import 'package:pinksecret_front/src/shared/utils/constants/image_constants.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = deviceType.value == DeviceType.mobile;

    return Center(
      child: OverflowBar(
        alignment: MainAxisAlignment.center,
        overflowAlignment: OverflowBarAlignment.center,
        children: [
          Image.asset(
            ImageConstants.logoResumida,
            height: MediaQuery.sizeOf(context).height * .09,
          ),
          Visibility(
            visible: !isMobile,
            child: Text(
              'Pinksecret',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
