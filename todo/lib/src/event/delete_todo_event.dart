import 'package:todo/src/base/base_event.dart';
import 'package:todo/src/model/todo.dart';

class DeleteTodoEvent extends BaseEvent {
  late Todo todo;
  DeleteTodoEvent(this.todo);
}
