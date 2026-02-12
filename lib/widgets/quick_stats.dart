import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_app/providers/task_provider.dart';

class QuickStats extends StatelessWidget {
  const QuickStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, _) {
        final total = provider.tasks.length;
        final completed = provider.completedTasks.length;
        final pending = total - completed;
        final completionRate = total > 0
            ? (completed / total * 100).toStringAsFixed(0)
            : "0";

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF15B86C).withValues(alpha: 0.2),
                const Color(0xFF15B86C).withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF15B86C).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _QuickStatItem(icon: Icons.task_alt, value: total.toString(), label: "Total"),
              _QuickStatItem(icon: Icons.check_circle, value: completed.toString(), label: "Done"),
              _QuickStatItem(icon: Icons.pending, value: pending.toString(), label: "Pending"),
              _QuickStatItem(icon: Icons.percent, value: "$completionRate%", label: "Rate"),
            ],
          ),
        );
      },
    );
  }
}

class _QuickStatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _QuickStatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF15B86C), size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 11),
        ),
      ],
    );
  }
}
