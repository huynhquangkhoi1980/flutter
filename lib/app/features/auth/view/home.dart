import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/app/features/auth/bloc/auth_bloc.dart';
import 'package:mevn_app/app/features/auth/bloc/auth_state.dart';
import 'package:mevn_app/app/features/auth/view/login.dart';
import 'package:mevn_app/app/utils/route/app_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthBloc? _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(locator.get());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _authBloc!..loadedAuth(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is LoadedAppState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (state is LoginState) {
              final user = state.data;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.orange[400],
                  title: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        '${user.photoUrl}',
                        height: 40,
                        width: 40,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    title: Text(
                      'Welcome, ${user.displayName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    const SizedBox(
                      width: 30,
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu),
                      tooltip: 'Show Snackbar',
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 150,
                              color: const Color.fromARGB(255, 247, 245, 245),
                              child: Center(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Card(
                                      color: const Color.fromARGB(
                                        255,
                                        204,
                                        203,
                                        203,
                                      ),
                                      elevation: 0,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: ListTile(
                                        title: const Text(
                                          'Logout',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _authBloc!.logout();
                                        },
                                        trailing: const Icon(Icons.logout),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: Card(
                            shadowColor: Colors.grey.shade100,
                            color: const Color.fromARGB(255, 247, 245, 245),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            margin: const EdgeInsets.only(bottom: 14),
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(bottom: 5),
                              title: const Center(
                                child: Text(
                                  'KICKOFF',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  AppRoute.routeKickoff,
                                  (route) => false,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is LogoutState) {
              return const LoginScreen();
            } else {
              return Container();
            }
          }
        },
      ),
    );
  }
}
