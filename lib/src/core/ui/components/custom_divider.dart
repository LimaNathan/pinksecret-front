import 'package:flutter/material.dart';

class CustomDivider extends StatefulWidget {
  const CustomDivider({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<CustomDivider> createState() => _CustomDividerState();
}

class _CustomDividerState extends State<CustomDivider> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: (widget.width ?? width) * 0.01,
        vertical: (widget.height ?? height) * 0.01,
      ),
      height: (widget.height ?? height),
      width: (widget.width ?? width) * 0.001,
      color: Theme.of(context).colorScheme.surfaceVariant,
    );
  }
}
