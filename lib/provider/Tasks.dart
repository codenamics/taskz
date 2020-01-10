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

  Task findById(String id) {
    return _tasks.firstWhere((task) => task.id == id);
  }


void addTask(Task task) {
  var taskItem = Task(id: task.id, title: task.title, description: task.description);
    _tasks.add(taskItem);
    notifyListeners();
  }

   Future<void> toggleStatus(id) async {
    var taskID = _tasks.firstWhere((task) => task.id == id);
    if(taskID.isCompleted){
      taskID.isCompleted = false;
    }else{
      taskID.isCompleted = true;
    }
   
    notifyListeners();
  }
void removeTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }


}