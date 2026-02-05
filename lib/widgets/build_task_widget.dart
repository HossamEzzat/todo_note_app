import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_note_app/models/task_model.dart';

class BuildTaskWidget extends StatefulWidget {
  const BuildTaskWidget({super.key});

  @override
  State<BuildTaskWidget> createState() => _BuildTaskWidgetState();
}

class _BuildTaskWidgetState extends State<BuildTaskWidget> {
  List<TaskModel> _tasks = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString("tasks");

    setState(() {
      _tasks = tasksJson != null
          ? (jsonDecode(tasksJson) as List)
                .map((item) => TaskModel.fromJson(item))
                .toList()
          : [];
      isLoading = false;
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      "tasks",
      jsonEncode(_tasks.map((task) => task.toJson()).toList()),
    );
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      _saveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const Center(
            child: CircularProgressIndicator(color: Color(0xFF15B86C)),
          )
        : (_tasks.isEmpty)
        ? Center(
            child: Text(
              "No tasks for today!",
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.only(bottom: 40),
            itemCount: _tasks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final task = _tasks[index];
              return Container(
                height: 56,
                padding: const EdgeInsets.only(left: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF282828),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) => _toggleTask(index),
                      activeColor: const Color(0xFF15B86C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.taskName,
                            style: TextStyle(
                              color: task.isCompleted
                                  ? const Color(0xFFA0A0A0)
                                  : const Color(0xFFFFFCFC),
                              fontSize: 16,
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              decorationColor: const Color(0xFFA0A0A0),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (task.taskDescription.isNotEmpty)
                            Text(
                              task.taskDescription,
                              style: const TextStyle(
                                color: Color(0xFFC6C6C6),
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      color: task.isCompleted
                          ? const Color(0xFFA0A0A0)
                          : const Color(0xFFFFFCFC),
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            },
          );
  }
}
