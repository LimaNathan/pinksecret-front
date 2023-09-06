import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Usuário'),
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text('Senha'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FilledButton(
              onPressed: () {},
              child: Text(
                'Entrar',
              ),
            ),
          ),
        ],
      )),
    );
  }
}
