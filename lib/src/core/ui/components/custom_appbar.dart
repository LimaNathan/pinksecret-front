import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinksecret_front/src/core/ui/components/custom_divider.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/home_atoms.dart';

class CustomAppbar extends StatelessWidget
    with HookMixin
    implements PreferredSizeWidget {
  final double size;
  const CustomAppbar({
    super.key,
    required this.size,
  });
  @override
  Size get preferredSize => Size.fromHeight(size);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final state = useAtomState(homeState);

    var label = state.when(
      init: () => '',
      dashboard: (_) => 'Dashboard',
      shop: (_) => 'Nova venda',
      storage: (_) => 'Lista de todos os produtos',
    );

    return AppBar(
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          height: 1,
          width: width,
        ),
      ),
      centerTitle: false,
      title: SizedBox(
        width: width * .45,
        child: Text(
          label,
          style: GoogleFonts.nunito(),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.circle_notifications_rounded,
                ),
              ),
              CustomDivider(),
              CircleAvatar(
                child: Icon(Icons.person),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.01,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nome',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Cargo',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 8,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
