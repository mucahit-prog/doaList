class ToDo {
  String? todoName;
  String? key;

  ToDo({required this.todoName});

  ToDo.fromJson(Map<String, dynamic> json) {
    todoName = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.todoName;
    return data;
  }
}

class ToDoList {
  List<ToDo> todos = [];

  ToDoList.fromJsonList(Map values) {
    values.forEach((key, value) {
      
      var todo = ToDo.fromJson(value);
      
      todo.key = key;
      todos.add(todo);
    });
  }
}