import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:pinksecret_front/src/core/ui/components/show_custom_loading.dart';
import 'package:pinksecret_front/src/core/ui/components/show_custom_notification.dart';
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
  void initState() {
    super.initState();
    verifyAuthAction.call();
  }

  @override
  Widget build(BuildContext context) {
    useAtomState(authState).when(
      init: () {},
      loading: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          LoadingOverlay.show(context);
        });
      },
      unlogged: (state) {
        LoadingOverlay.hide();
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => showCustomNotification(
            context,
            message: state.message ??
                'Nenhuma sessão ativa, faça o login novamente.',
            color: Theme.of(context).colorScheme.error,
          ),
        );
      },
    );

    return Material(
      child: Row(
        children: const [
          LoginBackground(),
          LoginForm(),
        ],
      ),
    );
  }
}
