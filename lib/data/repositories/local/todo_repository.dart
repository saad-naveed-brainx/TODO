import 'package:app/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoRepository {
  // Future<void> saveTodo(List<TodoModel> newTodos) async {
  //   final prefs = await SharedPreferences.getInstance();

  //   final String? existingData = prefs.getString('todos');
  //   List<TodoModel> allTodos = [];

  //   if (existingData != null && existingData.isNotEmpty) {
  //     final List<dynamic> decoded = jsonDecode(existingData);
  //     allTodos = decoded.map((item) => TodoModel.fromJson(item)).toList();
  //   }

  //   allTodos.addAll(newTodos);

  //   final String encodedData = jsonEncode(
  //     allTodos.map((todo) => todo.toJson()).toList(),
  //   );
  //   await prefs.setString('todos', encodedData);
  // }

  Future<void> saveTodo(List<TodoModel> newTodos) async {
    final prefs = await SharedPreferences.getInstance();
    final String? existingData = prefs.getString('todos');
    List<TodoModel> allTodos = [];

    if (existingData != null && existingData.isNotEmpty) {
      final List<dynamic> decoded = jsonDecode(existingData);
      allTodos = decoded.map((item) => TodoModel.fromJson(item)).toList();
    }

    // Create a map of existing todos by id for quick lookup
    final Map<String, TodoModel> todoMap = {
      for (var todo in allTodos) todo.id: todo,
    };

    // Add or update entries from newTodos
    for (var todo in newTodos) {
      todoMap[todo.id] = todo; // This updates if id exists or adds if not
    }

    // Convert map back to list
    final updatedList = todoMap.values.toList();

    final String encodedData = jsonEncode(
      updatedList.map((todo) => todo.toJson()).toList(),
    );
    await prefs.setString('todos', encodedData);
  }

  Future<List<TodoModel>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('todos');

    if (encodedData == null || encodedData.isEmpty) return [];

    final List<dynamic> decodedData = jsonDecode(encodedData);
    return decodedData.map((todo) => TodoModel.fromJson(todo)).toList();
  }

  Future<void> deleteTodo(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? encodedData = prefs.getString('todos');
      if (encodedData == null || encodedData.isEmpty) return;

      final List decoded = jsonDecode(encodedData);
      final todos = decoded.map((e) => TodoModel.fromJson(e)).toList();

      final updatedTodos = todos.where((t) => t.id != id).toList();

      await prefs.setString(
        'todos',
        jsonEncode(updatedTodos.map((e) => e.toJson()).toList()),
      );
    } catch (e) {
      print("error in deleting todo: $e");
    }
  }

  Future<void> updateTodo(TodoModel updatedTodo) async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('todos');
    if (encodedData == null || encodedData.isEmpty) return;

    final List decoded = jsonDecode(encodedData);
    final todos = decoded.map((e) => TodoModel.fromJson(e)).toList();

    int index = todos.indexWhere((t) => t.id == updatedTodo.id);
    if (index != -1) {
      todos[index] = updatedTodo;
      await prefs.setString(
        'todos',
        jsonEncode(todos.map((e) => e.toJson()).toList()),
      );
      print("Todo updated at index $index");
    } else {
      print("Todo with ID ${updatedTodo.id} not found. Skipping update.");
    }
  }
}
