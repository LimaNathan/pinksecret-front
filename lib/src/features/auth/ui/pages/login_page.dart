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

class _LoginPageState extends State<LoginPage> with HookStateMixin {
  @override
  Widget build(BuildContext context) {
    final state = useAtomState(authState)
      ..when(
          init: () {},
          unlogged: (unloggedState) {
            ScaffoldMessenger.of(context).showMaterialBanner(
                MaterialBanner(content: Text('teste'), actions: const []));
          });
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
