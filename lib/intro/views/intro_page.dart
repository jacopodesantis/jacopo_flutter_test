import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacopo_flutter_test/general/widgets/app_button.dart';
import 'package:jacopo_flutter_test/home/views/home_page.dart';
import 'package:jacopo_flutter_test/user/bloc/user_bloc.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  bool _visible = false;
  bool _isAnimationEnded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        setState(() {
          _visible = true;
        });
      },
    );
    Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          _isAnimationEnded = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserAuthenticationLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          if (state is UserAuthenticated && _isAnimationEnded) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(
                context,
                HomePage.routeName,
              );
            });
          }
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: ((state is UserUnauthenticated ||
                          state is UserWrongCredentials) &&
                      _isAnimationEnded)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: const Duration(seconds: 1),
                    child: AnimatedContainer(
                      height: ((state is UserUnauthenticated ||
                                  state is UserWrongCredentials) &&
                              _isAnimationEnded)
                          ? 50
                          : 200,
                      duration: const Duration(milliseconds: 500),
                      child: Image.asset(
                        'assets/images/3bee_logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                if ((state is UserUnauthenticated ||
                        state is UserWrongCredentials) &&
                    _isAnimationEnded)
                  AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: const Duration(seconds: 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextField(
                            controller: emailController,
                            autocorrect: false,
                            decoration: InputDecoration(
                              label: const Text('Email'),
                              floatingLabelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            cursorColor: Theme.of(context).primaryColor,
                          ),
                          TextField(
                            controller: pwController,
                            obscureText: true,
                            decoration: InputDecoration(
                              label: const Text('Password'),
                              floatingLabelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            cursorColor: Theme.of(context).primaryColor,
                          ),
                          if (state is UserWrongCredentials)
                            const Text(
                              'Attenzione credenziali non corrette!',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          AppButton(
                            'Login',
                            () {
                              context.read<UserBloc>().add(
                                    UserLoggingIn(
                                      email: emailController.text,
                                      pw: pwController.text,
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
