import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogTitles extends StatefulWidget {
  final String? title;
  final Function()? onPressed;
  const DialogTitles({
    super.key,
    this.title,
    this.onPressed,
  });

  @override
  State<DialogTitles> createState() => _DialogTitlesState();
}

class _DialogTitlesState extends State<DialogTitles> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text(
            widget.title ?? 'Novo Produto',
            style:
                GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          IconButton(
            onPressed: widget.onPressed ?? Modular.to.pop,
            icon: Icon(
              FontAwesomeIcons.xmark,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
