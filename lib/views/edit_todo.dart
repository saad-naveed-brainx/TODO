import 'package:app/widgets/reuseable_create_edit_form.dart';
import 'package:app/viewmodels/change_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/models/todo_model.dart';

class EditTodo extends StatefulWidget {
  final TodoModel existingTodo;
  const EditTodo({super.key, required this.existingTodo});
  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  @override
  Widget build(BuildContext context) {
    return ReuseableCreateEditForm(
      existingTodo: widget.existingTodo,
      onSave: (todo) {
        context.read<TodoProvider>().updateTodo(todo);
      },
    );
  }
}
