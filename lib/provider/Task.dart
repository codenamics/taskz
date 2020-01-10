import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


class Task with ChangeNotifier {
  final String id;
  final String title;
  final String description;
   bool isCompleted;
  

  Task({
    @required this.id,
    @required this.title,
    @required this.description,
    this.isCompleted = false,
  });

  void _setIsCompleted(bool newValue) {
    isCompleted = newValue;
    notifyListeners();
  }

  Future<void> toggleStatus(String token, String userId) async {
    final oldStatus = isCompleted;
    isCompleted = !isCompleted;
    notifyListeners();
    final url =
        '';
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isCompleted,
        ),
      );
      if (response.statusCode >= 400) {
        _setIsCompleted(oldStatus);
      }
    } catch (error) {
      _setIsCompleted(oldStatus);
    }
  }
}
