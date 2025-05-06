import 'package:flutter/material.dart';
import '../views/create_todo.dart';
import '../views/view_all_todos.dart';
import '../views/detailed_view.dart';

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

  static moveToDetailedView(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailedView(id: id)),
    );
  }
}
