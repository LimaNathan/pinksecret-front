import 'package:flutter/material.dart';
import 'package:pinksecret_front/src/core/ui/components/password_form_field.dart';
import 'package:pinksecret_front/src/features/auth/interactor/atoms/auth_atoms.dart';
import 'package:pinksecret_front/src/features/auth/interactor/dto/user_dto.dart';
import 'package:pinksecret_front/src/shared/utils/constants/image_constants.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    UserDTO user = UserDTO();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      width: MediaQuery.sizeOf(context).width * .35,
      height: MediaQuery.sizeOf(context).height,
      child: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(ImageConstants.logoResumida),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  onChanged: (value) {
                    user.email = value;
                  },
                  decoration: InputDecoration(
                    label: Text('Usuário'),
                  ),
                ),
                PasswordFormField(
                  onChanged: (value) {
                    user.password = value;
                  },
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: () {
              loginAction.value = user;
            },
            child: Text(
              'Entrar',
            ),
          ),
        ],
      )),
    );
  }
}
