import 'package:flutter/material.dart';

class MemberItem extends StatelessWidget {
  const MemberItem({Key? key, this.title, this.route, this.avatar})
      : super(key: key);

  final String? title;
  final String? route;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(route!);
      },
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      leading: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets$avatar'),
      ),
      title: Text(title!),
    );
  }
}
