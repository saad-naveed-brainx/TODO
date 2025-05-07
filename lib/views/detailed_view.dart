import 'package:app/core/constants/app_constants.dart';
import 'package:app/core/constants/view_constants.dart';
import 'package:flutter/material.dart';
import 'package:app/viewmodels/change_notifier_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:app/config/theme/light.dart';
import 'package:app/config/app_router.dart';
import 'package:app/models/todo_model.dart';

class DetailedView extends StatelessWidget {
  final String id;
  DetailedView({super.key, required this.id});

  Future<void> _deleteTodo(String id, BuildContext context) async {
    await Provider.of<TodoProvider>(context, listen: false).deleteTodo(id);
    Navigator.pop(context, "deleted");
  }

  Future<void> _markAsDone(TodoModel todo, BuildContext context) async {
    await Provider.of<TodoProvider>(context, listen: false).markAsDone(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ViewConstants.detailedView)),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          final todo = provider.getTodoById(id);
          if (todo == null) {
            return const Center(child: Text("Todos not found"));
          }
          return Padding(
            padding: const EdgeInsets.all(AppConstants.gap20Px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                    fontSize: AppConstants.gap24Px * 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConstants.gap20Px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: LightTheme.calenderIconColor,
                        ),
                        const SizedBox(width: AppConstants.gap10Px),
                        Text(
                          DateFormat(
                            'dd/MM/yyyy',
                          ).format(todo.dateOfCompletion),
                          style: TextStyle(fontSize: AppConstants.gap22Px),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: LightTheme.calenderIconColor,
                        ),
                        const SizedBox(width: AppConstants.gap10Px),
                        Text(
                          todo.dueTime.format(context),
                          style: TextStyle(fontSize: AppConstants.gap22Px),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.gap20Px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.checklist_rtl_outlined,
                          color: LightTheme.calenderIconColor,
                        ),
                        const SizedBox(width: AppConstants.gap10Px),
                        Text(
                          todo.isDone
                              ? ViewConstants.todo
                              : ViewConstants.inProgress,
                          style: TextStyle(fontSize: AppConstants.gap22Px),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        AppRouter.moveToEditTodo(context, todo);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: LightTheme.calenderIconColor,
                          ),
                          const SizedBox(width: AppConstants.gap10Px),
                          Text(
                            ViewConstants.editTask,
                            style: TextStyle(fontSize: AppConstants.gap22Px),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.gap20Px),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ViewConstants.taskDescription,
                      style: TextStyle(
                        fontSize: AppConstants.gap22Px,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.gap24Px),
                    Text(todo.description),
                  ],
                ),
                const SizedBox(height: AppConstants.gap24Px * 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        onPressed: () => _markAsDone(todo, context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LightTheme.doneCardGreenColor,
                        ),
                        child: Text(
                          todo.isDone
                              ? ViewConstants.completed
                              : ViewConstants.markAsDone,
                          style: TextStyle(fontSize: AppConstants.gap22Px),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        onPressed: () => _deleteTodo(id, context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LightTheme.deleteButtonRedColor,
                        ),
                        child: Text(
                          ViewConstants.deleteTask,
                          style: TextStyle(fontSize: AppConstants.gap22Px),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
