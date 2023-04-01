import 'package:flutter/material.dart';
import 'package:todo/src/resource/todo/todo_header.dart';
import 'package:todo/src/resource/todo/todo_list.dart';

class TodoListContainer extends StatelessWidget {
  const TodoListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const TodoHeader(),
          const Expanded(
            child: TodoList(),
          ),
        ],
      ),
    );
  }
}
