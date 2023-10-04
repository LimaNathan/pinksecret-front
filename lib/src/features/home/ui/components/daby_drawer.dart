import 'package:flutter/material.dart';

class DabyDrawer extends StatefulWidget {
  const DabyDrawer({super.key});

  @override
  State<DabyDrawer> createState() => _DabyDrawerState();
}

class _DabyDrawerState extends State<DabyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('Item'),
        Text('Item'),
        Text('Item'),
        Text('Item'),
      ],
    );
  }
}
