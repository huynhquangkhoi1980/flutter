import 'package:todo/src/base/base_event.dart';

class AddTodoEvent extends BaseEvent {
  late String content;
  AddTodoEvent(this.content);
}
