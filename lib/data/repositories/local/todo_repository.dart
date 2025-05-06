import 'package:app/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoRepository {
  Future<void> saveTodo(List<TodoModel> newTodos) async {
    final prefs = await SharedPreferences.getInstance();

    // Load existing todos
    final String? existingData = prefs.getString('todos');
    List<TodoModel> allTodos = [];

    if (existingData != null && existingData.isNotEmpty) {
      final List<dynamic> decoded = jsonDecode(existingData);
      allTodos = decoded.map((item) => TodoModel.fromJson(item)).toList();
    }

    // Append new todos
    allTodos.addAll(newTodos);

    // Save updated list
    final String encodedData = jsonEncode(
      allTodos.map((todo) => todo.toJson()).toList(),
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
  }

  Future<void> updateTodo(TodoModel updatedTodo) async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('todos');
    if (encodedData == null || encodedData.isEmpty) return;

    final List decoded = jsonDecode(encodedData);
    final todos = decoded.map((e) => TodoModel.fromJson(e)).toList();

    final List<TodoModel> updatedList =
        todos.map((todo) {
          return todo.id == updatedTodo.id ? updatedTodo : todo;
        }).toList();

    await prefs.setString(
      'todos',
      jsonEncode(updatedList.map((e) => e.toJson()).toList()),
    );
  }
}
