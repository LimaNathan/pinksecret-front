import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/features/auth/interactor/atoms/auth_atoms.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/auth_state.dart';
import 'package:pinksecret_front/src/shared/theme/custom_theme.dart';
import 'package:pinksecret_front/src/shared/utils/constants/routes.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    rxObserver(() => authState.value, effect: (state) {
      if (state is Unlogged) {
        Modular.to.navigate('${Routes.auth}${Routes.login}');
      } else if (state is Logged) {
        Modular.to.navigate(Routes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pink Secret',
      theme: CustomTheme.theme,
      routerConfig: Modular.routerConfig,
    );
  }
}
