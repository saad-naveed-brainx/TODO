import 'package:flutter/material.dart';
import '../views/create_todo.dart';
import '../views/view_all_todos.dart';
import '../views/detailed_view.dart';
import '../models/todo_model.dart';
import '../views/edit_todo.dart';

class AppRouter {
  static moveToCreateNewTodo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateNewTodo()),
    );
  }

  static moveToViewAllTodos(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ViewAllTodos()),
    );
  }

  static Future<dynamic> moveToDetailedView(BuildContext context, String id) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailedView(id: id)),
    );
    return result;
  }

  static moveToEditTodo(BuildContext context, TodoModel todo) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTodo(existingTodo: todo)),
    );
  }
}
