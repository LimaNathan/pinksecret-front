import 'package:asp/asp.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinksecret_front/src/core/interactor/atoms/core_atoms.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';
import 'package:pinksecret_front/src/features/auth/interactor/atoms/auth_atoms.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/auth_state.dart';
import 'package:pinksecret_front/src/shared/theme/material-theme/color_schemes.g.dart';
import 'package:pinksecret_front/src/shared/theme/material-theme/custom_color.g.dart';
import 'package:pinksecret_front/src/shared/utils/constants/nav_key.dart';
import 'package:pinksecret_front/src/shared/utils/constants/routes.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with HookStateMixin {
  @override
  Widget build(BuildContext context) {
    Modular.setNavigatorKey(NavKey.navKey);

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
            colorScheme: colorScheme,
            extensions: [customColors],
            useMaterial3: true,
            textTheme: TextTheme(
              bodyLarge: GoogleFonts.inter(),
              bodyMedium: GoogleFonts.inter(),
            ),
            dropdownMenuTheme: DropdownMenuThemeData(
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFA03C4C), width: 1.5),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: GoogleFonts.inter(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
              hintStyle: GoogleFonts.inter(
                color: Colors.black38,
                fontWeight: FontWeight.w300,
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFFA03C4C), width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error.withOpacity(0.5),
                    width: 1.5),
              ),
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: Color(0xFFA03C4C), // Cor de fundo do botão
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA03C4C), // Cor de fundo
                foregroundColor: Colors.white, // Cor do texto
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 3, // Sombra
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                textStyle: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                // backgroundColor: Color(0xFFA03C4C), // Cor do texto
                side: BorderSide(color: Color(0xFFA03C4C), width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),

                textStyle: GoogleFonts.inter(
                  color: Color(0xFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }

        return MaterialApp.router(
          builder: (context, child) {
            setDeviceType(
              switch (MediaQuery.sizeOf(context).width) {
                < 600 => DeviceType.mobile,
                >= 600 && < 1200 => DeviceType.tablet,
                >= 1200 => DeviceType.desktop,
                _ => DeviceType.desktop,
              },
            );

            useAtomEffect(
              (get) => get(authState),
              effect: (value) {
                final currentRoute = Modular.to.path;
                if (value is Unlogged &&
                    currentRoute != '${Routes.auth}${Routes.login}') {
                  Modular.to.navigate('${Routes.auth}${Routes.login}');
                } else if (value is Logged && currentRoute != Routes.home) {
                  Modular.to.navigate(Routes.home);
                }
              },
            );

            return child ?? Container();
          },
          debugShowCheckedModeBanner: false,
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
