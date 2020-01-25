import 'package:flutter/foundation.dart';

class Task with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final DateTime reminderDate;
  int notifyId;
  bool isCompleted;

  Task({
    this.id,
    this.title,
    this.description,
    this.reminderDate,
    this.notifyId,
    this.isCompleted = false,
    
  });

  void setReminder(bool newValue) {
    notifyListeners();
  }

  // void toggleStatus() {
  //   isCompleted = !isCompleted;
  //   notifyListeners();
  // }
}
