class Validators {
  static String? validateTaskTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Task title is required';
    }
    return null;
  }

  static String? validateTaskDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Task description is required';
    }
    return null;
  }

  static String? validateTaskDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Task date is required';
    }
    return null;
  }

  static String? validateTaskTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Task time is required';
    }
    return null;
  }
}
