import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tazks/Widgets/IsCompleted.dart';
import 'package:tazks/provider/Task.dart';
import 'package:http/http.dart' as http;

class Tasks with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks {
    return [..._tasks.reversed];
  }

  List<Task> get completed {
    return _tasks.where((task) => task.isCompleted).toList();
  }

  Task findById(String id) {
    return _tasks.firstWhere((task) => task.id == id);
  }

  // void renotify() {
  //   notifyListeners();
  // }

  Future fetchTodos() async {
    var url = 'https://draganddrop-c65b4.firebaseio.com/todos.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    List<Task> loadedTasks = [];

    extractedData.forEach((taskId, taskData) {
      loadedTasks.add(Task(
          id: taskId,
          title: taskData['title'],
          description: taskData['description'],
          isCompleted: taskData['isCompleted'],
          notifyId: taskData['notifyId'],
          reminderDate: taskData['reminderDate'] != null
              ? DateTime.parse(taskData['reminderDate'])
              : null));
    });
    _tasks = loadedTasks;
    notifyListeners();
  }

  Future addTask(Task task) async {
    var url = 'https://draganddrop-c65b4.firebaseio.com/todos.json';
    var res = await http.post(url,
        body: json.encode({
          'title': task.title,
          'description': task.description,
          'isCompleted': false
        }));

    await fetchTodos();
    notifyListeners();
  }

  Future<void> updateTask(String id, Task newTask) async {
    var url = 'https://draganddrop-c65b4.firebaseio.com/todos/$id.json';
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex >= 0) {
      try {
        await http.patch(url,
            body: json.encode({
              'title': newTask.title,
              'description': newTask.description,
            }));
        _tasks[taskIndex] = newTask;
        notifyListeners();
      } catch (e) {
        throw e;
      }
    } else {
      print('...');
    }
  }

  Future<void> updatedReminder(String id, Task newTask) async {
    var url = 'https://draganddrop-c65b4.firebaseio.com/todos/$id.json';
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex >= 0) {
      try {
        await http.put(url,
            body: json.encode({
              'title': newTask.title,
              'description': newTask.description,
              'isCompleted': newTask.isCompleted,
              'reminderDate': newTask.reminderDate.toString(),
              'notifyId': newTask.notifyId,
            }));
        _tasks[taskIndex] = newTask;
        notifyListeners();
      } catch (e) {
        throw e;
      }
    } else {
      print('...');
    }
  }

  Future<void> removeTask(String id) async {
    var url = 'https://draganddrop-c65b4.firebaseio.com/todos/$id.json';
    await http.delete(url);
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  Future<void> toogleStatus(String id) async {
    var url = 'https://draganddrop-c65b4.firebaseio.com/todos/$id.json';
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    notifyListeners();

    if (taskIndex >= 0) {
      try {
        await http.patch(url,
            body: json.encode({
              'isCompleted': _tasks[taskIndex].isCompleted,
            }));
      } catch (e) {
        throw e;
      }
    } else {
      print('...');
    }
  }
}
