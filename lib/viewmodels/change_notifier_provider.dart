import 'package:uuid/uuid.dart';
import 'package:app/models/todo_model.dart';
import 'package:app/data/repositories/local/todo_repository.dart';
import 'package:flutter/material.dart';

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

  Future<void> convertDataToModelAndSave(
    String title,
    String description,
    DateTime date,
    TimeOfDay time,
  ) async {
    TodoModel todo = TodoModel(
      id: generateId(),
      title: title,
      description: description,
      dateOfCompletion: date,
      dueTime: time,
    );
    todos.add(todo);
    await TodoRepository().saveTodo(todos);
    notifyListeners();
  }

  TodoModel getTodoById(String id) {
    return todos.firstWhere((todo) => todo.id == id);
  }
}
