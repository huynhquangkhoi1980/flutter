import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  final void Function(int)? onTap;

  const BottomNavigationWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState(
        onTap: onTap,
      );
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  _BottomNavigationWidgetState({
    required this.onTap,
  });

  late int currentIndex = 0;
  void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 1,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
      selectedItemColor: const Color.fromRGBO(239, 130, 0, 1),
      unselectedItemColor: const Color.fromARGB(255, 27, 27, 1),
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      onTap: (value) {
        onTap!(value);
        setState(() => currentIndex = value);
      },
      items: const [
        BottomNavigationBarItem(
          label: 'NEWS',
          icon: Icon(
            Icons.newspaper_outlined,
            size: 32,
          ),
        ),
        BottomNavigationBarItem(
          label: 'ACCOUNT',
          icon: Icon(
            Icons.person,
            size: 32,
          ),
        ),
      ],
    );
  }
}
