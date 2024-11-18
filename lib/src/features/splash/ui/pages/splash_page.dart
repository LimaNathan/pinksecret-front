import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/shared/utils/constants/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      Modular.to.pushNamed('${Routes.auth}${Routes.login}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: Text('Pink Secret')),
    );
  }
}
