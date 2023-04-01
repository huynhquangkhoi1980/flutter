import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/src/blocs/todo_bloc.dart';
import 'package:todo/src/event/delete_todo_event.dart';
import 'package:todo/src/model/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoBloc>(
        builder: (context, bloc, child) => StreamBuilder<List<Todo>>(
            stream: bloc.todoListStream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          snapshot.data![index].content,
                          style: const TextStyle(fontSize: 20),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            bloc.event
                                .add(DeleteTodoEvent(snapshot.data![index]));
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                  );
                case ConnectionState.waiting:
                  return const Center(
                    child:
                        SizedBox(width: 70, height: 70, child: Text("Empty")),
                  );
                case ConnectionState.none:
                default:
                  return const Center(
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularProgressIndicator(),
                    ),
                  );
              }
            }));
  }
}
