import 'package:flutter/material.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  bool isDone;
  final DateTime dateOfCompletion;
  final TimeOfDay dueTime;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
    required this.dateOfCompletion,
    required this.dueTime,
  });

  // Convert model to JSON-compatible map
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'isDone': isDone,
    'dateOfCompletion':
        dateOfCompletion.toIso8601String(), // standard string format
    'dueTime': '${dueTime.hour}:${dueTime.minute}', // manual string format
  };

  // Convert JSON-compatible map back to model
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    // Parse time manually
    final timeParts = (json['dueTime'] as String).split(':');
    final time = TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );

    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['isDone'],
      dateOfCompletion: DateTime.parse(json['dateOfCompletion']),
      dueTime: time,
    );
  }
}
