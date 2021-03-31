import 'dart:convert';
import 'dart:io';

import 'package:doalist/core/model/todo.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiService {
  String? _baseURL;

  static ApiService? _instance = ApiService._privateConstructor();
  ApiService._privateConstructor() {
    _baseURL = "https://accountadding-default-rtdb.firebaseio.com/";
  }

  static ApiService getInstance() {
    if (_instance == null) {
      return ApiService._privateConstructor();
    }
    return _instance!;
  }

  Future<List<ToDo>> getTodos() async {
    final response = await http.get(Uri.parse("$_baseURL/todo.json"));
    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
      print(ToDoList.fromJsonList(jsonResponse));
        final todoList = ToDoList.fromJsonList(jsonResponse);
        return todoList.todos;
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);

    return Future.error(jsonResponse);
  }

  Future<void> addTodo(ToDo todo) async {
    final jsonBody = json.encode(todo.toJson());
    final response = await http.post(Uri.parse("$_baseURL/todo.json"), body: jsonBody);
    
    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);

    return Future.error(jsonResponse);
  }

   Future<void> removeTodos(String key) async {
     
    final response = await http.delete(Uri.parse("$_baseURL/todo/$key.json"));
    print(response);
    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);

    return Future.error(jsonResponse);
  }
}