import 'package:flutter/material.dart';
import 'package:app/viewmodels/change_notifier_provider.dart';
import 'package:provider/provider.dart';
import 'package:app/widgets/reuseable_create_edit_form.dart';

class CreateNewTodo extends StatefulWidget {
  const CreateNewTodo({super.key});
  @override
  State<CreateNewTodo> createState() => _CreateNewTodoState();
}

class _CreateNewTodoState extends State<CreateNewTodo> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskTimeController = TextEditingController();
  final TextEditingController taskDateController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return ReuseableCreateEditForm(
      onSave: (todo) {
        context.read<TodoProvider>().convertDataToModelAndSave(todo);
      },
    );
  }
}
