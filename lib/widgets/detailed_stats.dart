import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_app/providers/task_provider.dart';

class DetailedStats extends StatelessWidget {
  const DetailedStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, _) {
        final total = provider.tasks.length;
        final completed = provider.completedTasks.length;
        final pending = total - completed;

        return Column(
          children: [
            Row(
              children: [
                _StatCard(
                  label: "Total Tasks",
                  value: total.toString(),
                  icon: Icons.list_alt,
                  color: Colors.blue,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: "Completed",
                  value: completed.toString(),
                  icon: Icons.check_circle,
                  color: const Color(0xFF15B86C),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _StatCard(
                  label: "Pending",
                  value: pending.toString(),
                  icon: Icons.pending_actions,
                  color: Colors.orange,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: "Progress",
                  value: "${total > 0 ? (completed / total * 100).toStringAsFixed(0) : 0}%",
                  icon: Icons.trending_up,
                  color: Colors.purple,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 24),
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
