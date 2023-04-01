import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/app/features/auth/bloc/auth_bloc.dart';
import 'package:mevn_app/app/features/auth/bloc/auth_state.dart';
import 'package:mevn_app/app/utils/route/app_route.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late AuthBloc? _authBloc;
  bool _loadImageError = false;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(locator.get());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          CustomContainerWidget(
            padding: const EdgeInsets.only(
              top: 8,
              left: 12,
              right: 12,
              bottom: 2,
            ),
            child: SvgPicture.asset(
              'assets/images/other/philosophy.svg',
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          BlocProvider(
            create: (_) => _authBloc!..checkAuthentication(),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is LoadedAppState ||
                    state is LogoutState ||
                    state is AuthenticationState) {
                  return AccountLoginWidget(
                    context: context,
                    authBloc: _authBloc,
                    state: state,
                  );
                }
                if (state is LoginState) {
                  final user = state.data;
                  return Column(
                    children: [
                      CustomContainerWidget(
                        height: 80,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: _loadImageError
                                  ? null
                                  : AssetImage(
                                      'assets/${user.photoUrl}',
                                    ),
                              onBackgroundImageError: _loadImageError
                                  ? null
                                  : (exception, stackTrace) {
                                      setState(() {
                                        _loadImageError = true;
                                      });
                                    },
                              child:
                                  _loadImageError ? const Text('Error!') : null,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${user.displayName}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${user.email}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomContainerWidget(
                        height: 118,
                        padding: EdgeInsetsDirectional.zero,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 58,
                              child: ListTile(
                                shape: const Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(239, 130, 0, 1),
                                  ),
                                ),
                                leading: const Icon(Icons.insert_chart),
                                horizontalTitleGap: 0,
                                title: const Text(
                                  'KICKOFF',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onTap: () => {},
                                trailing: const Icon(Icons.navigate_next),
                              ),
                            ),
                            SizedBox(
                              height: 58,
                              child: ListTile(
                                leading: const Icon(
                                  Icons.collections_bookmark_sharp,
                                ),
                                horizontalTitleGap: 0,
                                title: const Text(
                                  'ORDER BOOKS',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onTap: () => {
                                  Navigator.of(context).pushNamed(
                                  AppRoute.routeBookOrder,
                                )
                                },
                                trailing: const Icon(Icons.navigate_next),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomContainerWidget(
                        padding: EdgeInsetsDirectional.zero,
                        height: 56,
                        child: ListTile(
                          title: const Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () => _authBloc!.logout(),
                          trailing: const Icon(Icons.logout),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: const Text(
                    'MarketEnterprise Vietnam',
                    style: TextStyle(
                      color: Color.fromARGB(255, 16, 110, 219),
                    ),
                  ),
                  onTap: () =>
                      launchUrl(Uri.parse('https://www.marketenterprise.vn')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountLoginWidget extends StatelessWidget {
  const AccountLoginWidget({
    Key? key,
    required this.context,
    required this.authBloc,
    required this.state,
  }) : super(key: key);

  final BuildContext context;
  final AuthBloc? authBloc;
  final AuthState state;

  @override
  Widget build(BuildContext context) {
    final loadButton = (state is LoadedAppState)
        ? const CircularProgressIndicator(
            color: Colors.white,
          )
        : const Text(
            'LOGIN WITH GOOGLE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          );
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromRGBO(239, 130, 0, 1),
        ),
        onPressed: () => authBloc!.login(),
        child: Center(
          child: loadButton,
        ),
      ),
    );
  }
}

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({
    Key? key,
    required this.child,
    this.height = 200,
    this.padding = const EdgeInsets.all(8),
    this.border = const Border(
      top: BorderSide(
        color: Color.fromRGBO(239, 130, 0, 1),
      ),
      bottom: BorderSide(
        color: Color.fromRGBO(239, 130, 0, 1),
      ),
      left: BorderSide(
        color: Color.fromRGBO(239, 130, 0, 1),
      ),
      right: BorderSide(
        color: Color.fromRGBO(239, 130, 0, 1),
      ),
    ),
  }) : super(key: key);

  final Widget child;
  final double height;
  final EdgeInsetsGeometry? padding;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        border: border,
      ),
      child: child,
    );
  }
}
