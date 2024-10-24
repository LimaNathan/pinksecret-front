import 'package:flutter/material.dart';

class CustomSpacer extends StatelessWidget {
  final double? customHeight;
  final double? customWidth;
  const CustomSpacer({
    super.key,
    this.customHeight,
    this.customWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: customHeight ?? MediaQuery.sizeOf(context).height * .01,
      width: customWidth ?? MediaQuery.sizeOf(context).width * .01,
    );
  }
}
