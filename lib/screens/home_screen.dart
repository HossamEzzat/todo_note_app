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
          backgroundImage: AssetImage("assets/images/person.png"),
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
