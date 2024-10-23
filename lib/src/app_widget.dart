import 'package:asp/asp.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/features/auth/interactor/atoms/auth_atoms.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/auth_state.dart';
import 'package:pinksecret_front/src/shared/theme/material-theme/color_schemes.g.dart';
import 'package:pinksecret_front/src/shared/theme/material-theme/custom_color.g.dart';
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
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          lightCustomColors = lightCustomColors.harmonized(lightScheme);

          // Repeat for the dark color scheme.
          darkScheme = darkDynamic.harmonized();
          darkCustomColors = darkCustomColors.harmonized(darkScheme);
        } else {
          // Otherwise, use fallback schemes.
          lightScheme = lightColorScheme;
          darkScheme = darkColorScheme;
        }

        ThemeData themeDataProvider({
          required ColorScheme colorScheme,
          required CustomColors customColors,
        }) {
          return ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                gapPadding: 5,
              ),
            ),
            colorScheme: colorScheme,
            extensions: [customColors],
          );
        }

        return MaterialApp.router(
          themeMode: ThemeMode.light,
          title: 'Pink Secret',
          theme: themeDataProvider(
            colorScheme: lightScheme,
            customColors: lightCustomColors,
          ),
          darkTheme: themeDataProvider(
            colorScheme: darkScheme,
            customColors: darkCustomColors,
          ),
          routerConfig: Modular.routerConfig,
        );
      },
    );
  }
}
