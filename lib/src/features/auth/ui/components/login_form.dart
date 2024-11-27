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
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      width: width * .35,
      height: height,
      child: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(ImageConstants.logoResumida),
          SizedBox(
            height: height * .2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  onChanged: user.setEmail,
                  decoration: InputDecoration(
                    label: Text('Usuário'),
                  ),
                ),
                PasswordFormField(onChanged: user.setPassword),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => performLoginAction(user),
            child: Text('Entrar'),
          ),
        ],
      )),
    );
  }
}
