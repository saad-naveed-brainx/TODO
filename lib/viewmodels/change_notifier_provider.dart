import 'package:uuid/uuid.dart';
import 'package:app/models/todo_model.dart';
import 'package:app/data/repositories/local/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todos = [];
  String? _status;
  TodoProvider() {
    loadTodos();
  }
  void setStatus(String? status) {
    _status = status;
  }

  List<TodoModel> get todos {
    if (_status == "in-progress") {
      return _todos.where((todo) => todo.isDone == false).toList();
    } else if (_status == "completed") {
      return _todos.where((todo) => todo.isDone == true).toList();
    } else {
      return _todos;
    }
  }

  Future<void> loadTodos() async {
    _todos = await TodoRepository().getTodos();
    notifyListeners();
  }

  List<TodoModel>? getTodoForToday() {
    List<TodoModel> todos =
        _todos
            .where(
              (item) =>
                  DateFormat('dd-MM-yyyy').format(item.dateOfCompletion) ==
                  DateFormat('dd-MM-yyyy').format(DateTime.now()),
            )
            .toList();

    return todos.isNotEmpty ? todos : null;
  }

  static String generateId() {
    return Uuid().v4();
  }

  Future<void> convertDataToModelAndSave(TodoModel todo) async {
    _todos.add(todo);
    await TodoRepository().saveTodo(_todos);
    notifyListeners();
  }

  TodoModel? getTodoById(String id) {
    return _todos.firstWhereOrNull((todo) => todo.id == id);
  }

  Future<void> deleteTodo(String id) async {
    try {
      _todos.removeWhere((todo) => todo.id == id);

      await TodoRepository().deleteTodo(id);
    } catch (e) {
      print("error in deleting todo: $e");
    }
  }

  Future<void> markAsDone(TodoModel todo) async {
    todo.isDone = true;
    notifyListeners();
    await TodoRepository().updateTodo(todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    int index = _todos.indexWhere((test) => test.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      notifyListeners();
      await TodoRepository().updateTodo(todo);
    }
  }
}
