import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Task with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final DateTime reminderDate;
  bool isCompleted;

  Task({
    this.id,
    this.title,
    this.description,
    this.reminderDate,
    this.isCompleted = false,
  });

  void setReminder(bool newValue) {
    notifyListeners();
  }

  void toggleStatus() {
    isCompleted = !isCompleted;
    notifyListeners();
  }
}
