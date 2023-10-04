import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final String? label;
  final Function(String value)? onChanged;
  const PasswordFormField({
    super.key,
    this.label,
    this.onChanged,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool obscureText = true;

  void changeObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.only(
            right: 10,
          ),
          child: IconButton.outlined(
            onPressed: changeObscureText,
            icon: Icon(
              Icons.remove_red_eye,
            ),
          ),
        ),
        label: Text(widget.label ?? 'Senha'),
      ),
    );
  }
}
