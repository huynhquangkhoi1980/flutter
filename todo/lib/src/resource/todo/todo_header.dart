import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/src/blocs/todo_bloc.dart';
import 'package:todo/src/event/add_todo_event.dart';
import 'package:todo/src/resource/dialog/msg_dialog.dart';
// import 'package:todo/src/event/delete_todo_event.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var txtTodoController = TextEditingController();
    var bloc = Provider.of<TodoBloc>(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: txtTodoController,
            decoration: const InputDecoration(
                labelText: "Add todo", hintText: "Add todo"),
          ),
        ),
        const SizedBox(width: 20),
        TextButton.icon(
            onPressed: () {
              if (txtTodoController.text.trim().isEmpty) {
                MsgDialog.showMsgDialog(
                    context, "Alert", "Todo content must not blank");
                FocusScope.of(context);
              } else {
                bloc.event.add(AddTodoEvent(txtTodoController.text));
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Add')),
      ],
    );
  }
}
