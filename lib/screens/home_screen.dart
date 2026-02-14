import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_app/providers/task_provider.dart';
import 'package:todo_note_app/screens/add_task.dart';
import 'package:todo_note_app/widgets/List_tasks_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTask()),
          );
        },
        label: const Text(
          "Add Task",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: const Color(0xFF15B86C),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<TaskProvider>(
            builder: (context, provider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(provider.userName),
                  const SizedBox(height: 32),
                  _buildGreeting(),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff282828),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Achieved Tasks",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${provider.doneTasks} Out of ${provider.totalTasks} Done",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffc6c6c6),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentGeometry.center,
                          children: [
                            Transform.rotate(
                              angle: -pi / 2,
                              child: SizedBox(
                                height: 48,
                                width: 48,
                                child: CircularProgressIndicator(
                                  value: provider.completionPercentage,
                                  backgroundColor: Color(0xFF6D6D6D),
                                  valueColor: AlwaysStoppedAnimation(
                                    Color(0xff15B86C),
                                  ),
                                  strokeWidth: 5,
                                ),
                              ),
                            ),
                            Text(
                              "${(provider.completionPercentage * 100).toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "My Tasks",
                    style: TextStyle(
                      color: Color(0xFFFFFCFC),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListTasksWidget(
                      tasks: provider.tasks,
                      toggleTask: (task) => provider.toggleTaskState(task),
                      deleteTask: (task) => provider.deleteTask(task),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String userName) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage("assets/images/car.jpg"),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Evening, $userName",
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFFFFFCFC),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Text(
                "One task at a time. One step closer.",
                style: TextStyle(color: Color(0xFFC6C6C6), fontSize: 13),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color(0xFF1F1F1F),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.sunny, color: Colors.orangeAccent, size: 20),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    final textStyle = GoogleFonts.plusJakartaSans(
      color: const Color(0xFFFFFCFC),
      fontSize: 28,
      fontWeight: FontWeight.w500,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Yuhuu, Your work is", style: textStyle),
        Row(
          children: [
            Text("almost done! ", style: textStyle),
            SvgPicture.asset("assets/images/hand.svg", height: 28),
          ],
        ),
      ],
    );
  }
}
