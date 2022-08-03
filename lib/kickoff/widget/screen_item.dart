import 'package:flutter/material.dart';

class ScreenItem extends StatelessWidget {
  const ScreenItem({
    Key? key,
    this.title,
    this.route,
  }) : super(key: key);

  final String? title;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey.shade100,
      color: const Color.fromARGB(255, 230, 229, 229),
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
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Text(
          title!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(route!);
        },
        selectedColor: Colors.red,
      ),
    );
  }
}
