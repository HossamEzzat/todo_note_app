import 'dart:math';
import 'package:flutter/material.dart';

class AchievedTasksCard extends StatelessWidget {
  final int doneTasks;
  final int totalTasks;
  final double completionPercentage;

  const AchievedTasksCard({
    super.key,
    required this.doneTasks,
    required this.totalTasks,
    required this.completionPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Achieved Tasks",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              Text(
                "$doneTasks Out of $totalTasks Done",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffc6c6c6),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: -pi / 2,
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircularProgressIndicator(
                    value: completionPercentage,
                    backgroundColor: const Color(0xFF6D6D6D),
                    valueColor: const AlwaysStoppedAnimation(Color(0xff15B86C)),
                    strokeWidth: 5,
                  ),
                ),
              ),
              Text(
                "${(completionPercentage * 100).toStringAsFixed(0)}%",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
