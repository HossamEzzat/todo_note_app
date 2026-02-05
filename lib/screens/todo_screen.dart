import 'package:flutter/material.dart';
import 'package:todo_note_app/widgets/build_task_widget.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To Do Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BuildTaskWidget(),
      ),
    );
  }
}
