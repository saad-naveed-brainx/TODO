import 'package:flutter/material.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime dateOfCompletion;
  final TimeOfDay dueTime;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.dateOfCompletion,
    required this.dueTime,
  });
}
