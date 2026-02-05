import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_note_app/models/task_model.dart';
import 'package:todo_note_app/widgets/build_task_widget.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool isLoading = true;
  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString("tasks");
    setState(() {
      tasks = tasksJson != null
          ? (jsonDecode(tasksJson) as List)
                .map((item) => TaskModel.fromJson(item))
                .toList()
          : [];
      isLoading = false;
    });
  }

  void _toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
      _saveTasks();
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      "tasks",
      jsonEncode(tasks.map((task) => task.toJson()).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To Do Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BuildTaskWidget(tasks: tasks, toggleTask: _toggleTask),
      ),
    );
  }
}
