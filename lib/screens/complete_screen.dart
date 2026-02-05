import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_app/providers/task_provider.dart';
import 'package:todo_note_app/widgets/List_tasks_widget.dart';

class CompleteScreen extends StatelessWidget {
  const CompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Completed Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<TaskProvider>(
          builder: (context, provider, _) {
            final completedTasks = provider.completedTasks;
            return ListTasksWidget(
              tasks: completedTasks,
              toggleTask: (task) => provider.toggleTaskState(task),
              deleteTask: (task) => provider.deleteTask(task),
            );
          },
        ),
      ),
    );
  }
}
