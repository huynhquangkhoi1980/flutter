import 'dart:async';

import 'package:oktoast/oktoast.dart';
import 'package:todo/src/base/base_bloc.dart';
import 'package:todo/src/base/base_event.dart';
import 'package:todo/src/event/add_todo_event.dart';
import 'package:todo/src/event/delete_todo_event.dart';
import 'package:todo/src/event/read_todos_event.dart';
import 'package:todo/src/fire_base/fire_base_auth.dart';
import 'package:todo/src/model/todo.dart';

class TodoBloc extends BaseBloc {
  final StreamController<List<Todo>> _todoListStreamController =
      StreamController<List<Todo>>();

  final _firAuth = FirAuth();

  Stream<List<Todo>> get todoListStream => _todoListStreamController.stream;

  // ignore: deprecated_member_use
  final List<Todo> _todoListData = [];

  _addTodo(Todo todo) {
    todo.id = _firAuth.registerTodoTask(todo);
    _todoListData.insert(0, todo);
    _todoListStreamController.sink.add(_todoListData);
  }

  _deleteTodo(Todo todo) {
    try {
      _firAuth.removeTodoTask(todo);
      _todoListData.remove(todo);
      _todoListStreamController.sink.add(_todoListData);
    } catch (e) {
      showToast("Error by delete a todo");
    }
  }

  _readTodos(List<Todo> todos) async {
    try {
      var todoData = await _firAuth.readTodoTasks();
      // Sort todolist by alphabet
      todoData.sort((a, b) => (b.content).compareTo(a.content));
      _todoListData.clear();
      _todoListData.addAll(todoData);
      _todoListStreamController.sink.add(_todoListData);
      showToast('Data load successfully');
    } catch (err) {
      showToast('Data loading error');
    }
  }

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is AddTodoEvent) {
      Todo todo = Todo("", event.content, _firAuth.uid);
      _addTodo(todo);
    } else if (event is DeleteTodoEvent) {
      _deleteTodo(event.todo);
    } else if (event is ReadTodosEvent) {
      _readTodos(_todoListData);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _todoListStreamController.close();
  }
}
