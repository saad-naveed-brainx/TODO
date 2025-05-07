import 'package:uuid/uuid.dart';
import 'package:app/models/todo_model.dart';
import 'package:app/data/repositories/local/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> todos = [];

  TodoProvider() {
    loadTodos();
  }

  Future<void> loadTodos() async {
    todos = await TodoRepository().getTodos();
    notifyListeners();
  }

  static String generateId() {
    return Uuid().v4();
  }

  Future<void> convertDataToModelAndSave(TodoModel todo) async {
    todos.add(todo);
    await TodoRepository().saveTodo(todos);
    notifyListeners();
  }

  TodoModel? getTodoById(String id) {
    return todos.firstWhereOrNull((todo) => todo.id == id);
  }

  Future<void> deleteTodo(String id) async {
    try {
      todos.removeWhere((todo) => todo.id == id);

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
    int index = todos.indexWhere((test) => test.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      notifyListeners();
      await TodoRepository().updateTodo(todo);
    }
  }
}
