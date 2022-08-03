import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/app/features/auth/bloc/auth_bloc.dart';
import 'package:mevn_app/app/features/auth/bloc/auth_state.dart';
import 'package:mevn_app/app/features/auth/view/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc? _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(locator.get());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.orange[400],
            ),
          ),
          RotationTransition(
            turns: const AlwaysStoppedAnimation(46 / 360),
            child: Container(
              height: double.maxFinite,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          BlocProvider(
            create: (_) => _authBloc!..checkAuthentication(),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is LoadedAppState) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (state is LoginState) {
                    return const HomeScreen();
                  } else if (state is AuthenticationState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 70),
                            child: Image.asset(
                              'assets/images/logos/me_logo.png',
                              width: 260,
                              height: 100,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _authBloc!.login();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                            child: const Text(
                              'LOGIN WITH GOOGLE',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
