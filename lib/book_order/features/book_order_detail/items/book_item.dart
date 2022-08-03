import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  late String title;

  BookItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
