import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskProvider with ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<TaskModel> _tasks = [];
  String _userName = "User";
  bool _isLoading = true;

  List<TaskModel> get tasks => _tasks;
  List<TaskModel> get todoTasks => _tasks.where((t) => !t.isCompleted).toList();
  List<TaskModel> get completedTasks =>
      _tasks.where((t) => t.isCompleted).toList();
  String get userName => _userName;
  bool get isLoading => _isLoading;

  TaskProvider() {
    loadData();
  }

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    _tasks = await _taskService.getTasks();
    _userName = await _taskService.getUserName() ?? "User";

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(TaskModel task) async {
    _tasks.add(task);
    await _taskService.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> toggleTaskStatus(int index) async {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    await _taskService.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> toggleTaskState(TaskModel task) async {
    final index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      await _taskService.saveTasks(_tasks);
      notifyListeners();
    }
  }

  Future<void> deleteTask(TaskModel task) async {
    _tasks.remove(task);
    await _taskService.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> updateUserName(String name) async {
    _userName = name;
    await _taskService.saveUserName(name);
    notifyListeners();
  }

  Future<void> clearAllTasks() async {
    _tasks.clear();
    await _taskService.saveTasks(_tasks);
    notifyListeners();
  }
}
