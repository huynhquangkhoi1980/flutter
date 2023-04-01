import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo/src/model/todo.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Get id of the current login user
  String get uid => _firebaseAuth.currentUser!.uid;

  // SignUp funtion
  void signUp(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterError) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((user) {
        // case create successful
        _createUser(user.user!.uid, name, phone, onSuccess, onRegisterError);
      });
    } on FirebaseAuthException catch (e) {
      _onSignErr(e.code, onRegisterError);
    }
  }

  /*
  * Create a user node to firebase of users
  */
  _createUser(String userId, String name, String phone, Function onSuccess,
      Function(String) onRegisterError) {
    var user = {"name": name, "phone": phone};

    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userId).set(user).then((user) {
      onSuccess();
    }).catchError((err) {
      onRegisterError("Signup fail, please try again");
    });
  }

  // SignIn function
  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((user) {
        onSuccess();
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          onSignInError("The email address is badly formatted.");
          break;
        case "wrong-password":
          onSignInError(
              "The password is invalid or the user does not have a password.");
          break;
        default:
          onSignInError("Sign In fail, please try again");
          break;
      }
    }
  }

  // Check error
  void _onSignErr(String code, Function(String p1) onRegisterError) {
    switch (code) {
      case "ERROR＿INVALID＿EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email has exists");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("The password is not strong enough");
        break;
      case "invalid-email":
        onRegisterError("The registered email format is invalid!");
        break;
      default:
        onRegisterError("Signup fail, please try again");
        break;
    }
  }

  // Register todo task
  registerTodoTask(Todo todo) {
    var ref = FirebaseDatabase.instance.reference().child("todos").push();
    ref.set(todo.mapInputTodo()).then((todo) {}).catchError((err) {
      // ignore: avoid_print
      print("register fail");
    });
    return ref.key;
  }

  // Delete todo task
  void removeTodoTask(Todo todo) {
    // _deleteTodo(todo);
    // Access to todos on firebase
    var ref = FirebaseDatabase.instance.reference().child("todos");
    // Remove a todo task
    ref.child(todo.id.toString()).remove();
  }

  /*
  * Load Todolist when init the todo page
  */
  Future<List<Todo>> readTodoTasks() async {
    var ref = FirebaseDatabase.instance
        .reference()
        .child("todos")
        .orderByChild("userId")
        .equalTo(_firebaseAuth.currentUser!.uid.toString());
    Map<dynamic, dynamic> todoData = (await ref.once()).value;

    List<Todo> todoList = [];
    // Get all todos and set it on todoList
    todoList = todoData.entries
        .map((e) => Todo(e.key, e.value['content'], e.value['userId']))
        .toList();
    return todoList;
  }

  // Sign out
  Future signOut(Function onSuccess, Function(String) onSignInError) async {
    try {
      await _firebaseAuth.signOut().then((value) => {onSuccess()});
    } on FirebaseAuthException {
      // ignore: avoid_print
      onSignInError("Sign out error!");
      // return null;
    }
  }
}
