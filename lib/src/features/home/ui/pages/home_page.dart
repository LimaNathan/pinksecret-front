import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinksecret_front/src/core/interactor/atoms/core_atoms.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/home_atoms.dart';
import 'package:pinksecret_front/src/features/home/iteractor/states/home_states.dart';
import 'package:pinksecret_front/src/shared/utils/constants/image_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = deviceType.value == DeviceType.mobile;
    final state = context.select(() => homeState.value);
    final customHeight =
        isMobile ? MediaQuery.sizeOf(context).height * .02 : null;

    return Material(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.sizeOf(context).width * .02,
              right: MediaQuery.sizeOf(context).width * .01,
            ),
            width: MediaQuery.sizeOf(context).width * .2,
            child: Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Center(
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
                          style: GoogleFonts.montserrat(
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
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Divider(),
                ),
                CustomSpacer(),
                DrawerButton(
                  label: 'Dashboard',
                  icon: Icons.dashboard_rounded,
                  isSelected: state is DashboardState,
                  selected: toDashboard.call,
                ),
                CustomSpacer(customHeight: customHeight),
                DrawerButton(
                  label: 'Estoque',
                  icon: Icons.storage_rounded,
                  isSelected: state is StorageState,
                  selected: toStorageAction.call,
                ),
                CustomSpacer(customHeight: customHeight),
                DrawerButton(
                  label: 'Venda',
                  icon: Icons.sell,
                  isSelected: state is ShopState,
                  selected: toShopAction,
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width * 0.001,
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
          Flexible(
            flex: 5,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: Text('Pinksecret'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

class DrawerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Function() selected;
  const DrawerButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = deviceType.value == DeviceType.mobile;
    final borderRadius = BorderRadius.circular(8);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      splashColor: colorScheme.tertiaryContainer,
      borderRadius: borderRadius,
      onTap: selected,
      child: Visibility(
        visible: !isMobile,
        replacement: IconDrawerButton(
          isSelected: isSelected,
          colorScheme: colorScheme,
          borderRadius: borderRadius,
          icon: icon,
        ),
        child: DrawerTextButton(
          isSelected: isSelected,
          colorScheme: colorScheme,
          borderRadius: borderRadius,
          icon: icon,
          label: label,
        ),
      ),
    );
  }
}

class IconDrawerButton extends StatelessWidget {
  const IconDrawerButton({
    super.key,
    required this.isSelected,
    required this.colorScheme,
    required this.borderRadius,
    required this.icon,
  });

  final bool isSelected;
  final ColorScheme colorScheme;
  final BorderRadius borderRadius;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, right: 15, left: 15, top: 10),
      decoration: BoxDecoration(
        boxShadow: !isSelected
            ? null
            : [
                BoxShadow(
                  spreadRadius: 10,
                  blurRadius: 25,
                  color: colorScheme.surfaceTint.withOpacity(
                    0.1,
                  ),
                ),
              ],
        borderRadius: borderRadius,
        border: isSelected
            ? BorderDirectional(
                bottom: BorderSide(
                  color: colorScheme.tertiary,
                  width: 4,
                ),
              )
            : null,
      ),
      child: Icon(
        icon,
        color: !isSelected ? null : colorScheme.tertiary,
      ),
    );
  }
}

class DrawerTextButton extends StatelessWidget {
  const DrawerTextButton({
    super.key,
    required this.isSelected,
    required this.colorScheme,
    required this.borderRadius,
    required this.icon,
    required this.label,
  });

  final bool isSelected;
  final ColorScheme colorScheme;
  final BorderRadius borderRadius;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        boxShadow: !isSelected
            ? null
            : [
                BoxShadow(
                  spreadRadius: 10,
                  blurRadius: 25,
                  color: colorScheme.surfaceTint.withOpacity(
                    0.1,
                  ),
                ),
              ],
        borderRadius: borderRadius,
        border: isSelected
            ? BorderDirectional(
                bottom: BorderSide(
                  color: colorScheme.tertiary,
                  width: 4,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: !isSelected ? null : colorScheme.tertiary,
          ),
          CustomSpacer(),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                color: !isSelected ? null : colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
