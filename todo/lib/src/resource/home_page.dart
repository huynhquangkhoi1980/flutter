// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:todo/src/app.dart';
import 'package:todo/src/blocs/todo_bloc.dart';
import 'package:todo/src/event/read_todos_event.dart';
import 'package:todo/src/fire_base/fire_base_auth.dart';
import 'package:todo/src/resource/dialog/loading_dialog.dart';
import 'package:todo/src/resource/dialog/msg_dialog.dart';
import 'package:todo/src/resource/login_page.dart';
import 'package:todo/src/resource/todo/todo_list_container.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirAuth firAuth = FirAuth();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Todo List"),
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: onSignInClicked,
                  icon: const Icon(Icons.person),
                  label: const Text('Logout'))
            ],
          ),
          body: Provider<TodoBloc>.value(
              value: TodoBloc()..event.add(ReadTodosEvent()),
              child: const TodoListContainer())),
    );
  }

  void onSignInClicked() async {
    var authBloc = MyApp.of(context)!.authBloc;
    LoadingDialog.showLoadingDialog(context, "Logging out...");
    authBloc.signOut(() {
      LoadingDialog.hideLoagingDialog(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginPage()));
    }, (msg) {
      LoadingDialog.hideLoagingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign-In", msg);
    });
  }
}
