import 'package:flutter/material.dart';
import 'package:pinksecret_front/src/shared/utils/constants/image_constants.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .65,
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            ImageConstants.background,
            fit: BoxFit.cover,
            color: Colors.pink,
            colorBlendMode: BlendMode.modulate,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageConstants.logo),
              Text(
                'MODA ÍNTIMA',
                softWrap: true,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
