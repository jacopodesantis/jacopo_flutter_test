import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacopo_flutter_test/general/widgets/app_button.dart';
import 'package:jacopo_flutter_test/general/widgets/app_text_input.dart';
import 'package:jacopo_flutter_test/user/bloc/user_bloc.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback callback;
  const LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoginError = false;

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserAuthenticationError) {
                  setState(() {
                    isLoginError = true;
                  });
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (isLoginError)
                    Text(
                      'Wrong credentials',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.red),
                    ),
                  AppTextInput(
                    label: 'E-mail',
                    controller: widget.emailController,
                    isEmailInput: true,
                    isError: isLoginError,
                  ),
                  AppTextInput(
                    label: 'Password',
                    controller: widget.passwordController,
                    isPassword: true,
                    isError: isLoginError,
                  ),
                  AppButton(
                    'Login',
                    () {
                      widget.callback();
                    },
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
