import 'package:flutter/material.dart';
import 'package:app/core/constants/view_constants.dart';
import 'package:app/core/constants/app_constants.dart';
import 'package:app/config/theme/light.dart';
import 'package:app/viewmodels/validators.dart';
import 'package:app/viewmodels/change_notifier_provider.dart';
import 'package:app/models/todo_model.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ReuseableCreateEditForm extends StatefulWidget {
  final TodoModel? existingTodo;
  final Function(TodoModel) onSave;
  const ReuseableCreateEditForm({
    super.key,
    this.existingTodo,
    required this.onSave,
  });

  @override
  State<ReuseableCreateEditForm> createState() =>
      _ReuseableCreateEditFormState(existingTodo: existingTodo);
}

class _ReuseableCreateEditFormState extends State<ReuseableCreateEditForm> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskTimeController = TextEditingController();
  final TextEditingController taskDateController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TodoModel? existingTodo;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.existingTodo != null) {
        taskTitleController.text = widget.existingTodo!.title;
        taskDescriptionController.text = widget.existingTodo!.description;
        taskTimeController.text = widget.existingTodo!.dueTime.format(context);
        taskDateController.text =
            "${widget.existingTodo!.dateOfCompletion.day}/${widget.existingTodo!.dateOfCompletion.month}/${widget.existingTodo!.dateOfCompletion.year}";
        selectedDate = widget.existingTodo!.dateOfCompletion;
        selectedTime = widget.existingTodo!.dueTime;
      }
    });
  }

  _ReuseableCreateEditFormState({required this.existingTodo});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        taskDateController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
        taskTimeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    taskTimeController.dispose();
    taskDateController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Card(
            color: LightTheme.yellowText,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.gap18Px),
            ),
            child: Icon(Icons.arrow_back, color: LightTheme.normalTextColor),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () async {
                final todo = TodoModel(
                  id: widget.existingTodo?.id ?? TodoProvider.generateId(),
                  title: taskTitleController.text,
                  description: taskDescriptionController.text,
                  dateOfCompletion: selectedDate!,
                  dueTime: selectedTime!,
                  isDone: widget.existingTodo?.isDone ?? false,
                );

                if (widget.existingTodo != null) {
                  await context.read<TodoProvider>().updateTodo(todo);
                } else {
                  await widget.onSave(todo);
                }
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: LightTheme.yellowText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.gap18Px),
                ),
              ),
              child: Text(
                ViewConstants.saveNewTodo,
                style: TextStyle(
                  fontSize: AppConstants.font24Px,
                  color: LightTheme.normalTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.gap24Px),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: taskTitleController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    validator: Validators.validateTaskTitle,
                    decoration: InputDecoration(
                      hintText: ViewConstants.taskTitle,
                      contentPadding: EdgeInsets.all(AppConstants.gap10Px),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.gap10Px,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: LightTheme.yellowText),
                        borderRadius: BorderRadius.circular(
                          AppConstants.gap10Px,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.gap24Px),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: taskDateController,
                          validator: Validators.validateTaskDate,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: InputDecoration(
                            hintText: ViewConstants.taskDate,
                            contentPadding: EdgeInsets.all(
                              AppConstants.gap10Px,
                            ),
                            suffixIcon: Icon(Icons.calendar_month),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.gap10Px,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: LightTheme.yellowText,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppConstants.gap10Px,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: AppConstants.gap10Px),
                      Expanded(
                        child: TextFormField(
                          controller: taskTimeController,
                          validator: Validators.validateTaskTime,
                          readOnly: true,
                          onTap: () => _selectTime(context),
                          decoration: InputDecoration(
                            hintText: ViewConstants.taskTime,
                            contentPadding: EdgeInsets.all(
                              AppConstants.gap10Px,
                            ),
                            suffixIcon: Icon(Icons.access_time),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.gap10Px,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: LightTheme.yellowText,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppConstants.gap10Px,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.gap24Px),
                  TextFormField(
                    controller: taskDescriptionController,
                    validator: Validators.validateTaskDescription,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    maxLines: 20,
                    minLines: 10,
                    decoration: InputDecoration(
                      hintText: ViewConstants.taskDescription,
                      contentPadding: EdgeInsets.all(AppConstants.gap10Px),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.gap10Px,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: LightTheme.yellowText),
                        borderRadius: BorderRadius.circular(
                          AppConstants.gap10Px,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
