import 'package:flutter/material.dart';
import 'package:todo_note_app/models/task_model.dart';

class ListTasksWidget extends StatelessWidget {
  const ListTasksWidget({
    super.key,
    required this.tasks,
    required this.toggleTask,
  });

  final List<TaskModel> tasks;
  final Function(int index) toggleTask;

  @override
  Widget build(BuildContext context) {
    return (tasks.isEmpty)
        ? Center(
            child: Text(
              "No tasks for today!",
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.only(bottom: 40),
            itemCount: tasks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final task = tasks[index];
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
                      onChanged: (value) => toggleTask(index),
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
