import 'dart:developer';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:pinksecret_front/src/features/auth/interactor/atoms/auth_atoms.dart';
import 'package:pinksecret_front/src/features/auth/ui/components/login_background.dart';
import 'package:pinksecret_front/src/features/auth/ui/components/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final state = context.select(() => authState.value);

    log(state.toString());
    return Material(
      child: state.when(
        init: () {
          return Row(
            children: const [
              LoginBackground(),
              LoginForm(),
            ],
          );
        },
        logged: (state) {
          return Container();
        },
        loading: (state) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
