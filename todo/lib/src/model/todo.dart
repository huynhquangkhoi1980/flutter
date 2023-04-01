class Todo {
  String _id;
  String _content;
  String _userId;

  Todo(this._id, this._content, this._userId);

  // ignore: unnecessary_getters_setters
  String get content => _content;

  // ignore: unnecessary_getters_setters
  set content(String value) {
    _content = value;
  }

  // ignore: unnecessary_getters_setters
  String get id => _id;

  // ignore: unnecessary_getters_setters
  set id(String value) {
    _id = value;
  }

  // ignore: unnecessary_getters_setters
  String get userId => _userId;

  // ignore: unnecessary_getters_setters
  set userId(String userId) {
    _userId = userId;
  }

  //convert todo to Map
  Map<String, dynamic> mapTodo() {
    // var map = Map<String, dynamic>();
    var map = <String, dynamic>{};

    map['id'] = _id;
    map['content'] = _content;
    map['userId'] = _userId;
    return map;
  }

  //convert post to Map due to save todo into DB
  Map<String, dynamic> mapInputTodo() {
    // var map = Map<String, dynamic>();
    var map = <String, dynamic>{};

    map['content'] = _content;
    map['userId'] = _userId;
    return map;
  }
}
