import 'package:flutter/material.dart';
import 'package:tazks/provider/Task.dart';

class Tasks with ChangeNotifier {
  List<Task> _tasks = [
    Task(id: '1',title: 'React', description: 'qwsazxcdfed'),
    Task(id: '2',title: 'React', description: 'qwsazxcdfed', isCompleted: true),
    Task(id: '3',title: 'React', description: 'qwsazxcdfed', isCompleted: true),
    Task(id: '4',title: 'React', description: 'qwsazxcdfed'),
    Task(id: '5',title: 'React', description: 'qwsazxcdfed'),
    Task(id: '6',title: 'React', description: 'qwsazxcdfed', isCompleted: true),
  ];

  List<Task> get tasks {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._tasks];
  }

void removeTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }
}