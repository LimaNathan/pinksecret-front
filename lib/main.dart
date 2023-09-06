import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/app_module.dart';
import 'package:pinksecret_front/src/app_widget.dart';

void main() {
  runApp(
    RxRoot(
      child: ModularApp(
        module: AppModule(),
        child: AppWidget(),
      ),
    ),
  );
}
