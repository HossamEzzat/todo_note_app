import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_note_app/models/task_model.dart';
import 'package:todo_note_app/screens/add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userName;
  List<TaskModel> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Combined initialization for better performance
  Future<void> _initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString("name") ?? "User";
      _loadTasksFromPrefs(prefs);
      _isLoading = false;
    });
  }

  void _loadTasksFromPrefs(SharedPreferences prefs) {
    final String? tasksJson = prefs.getString("tasks");
    if (tasksJson != null) {
      final List<dynamic> decodedData = jsonDecode(tasksJson);
      _tasks = decodedData.map((item) => TaskModel.fromJson(item)).toList();
    }
  }

  // Refreshes data when returning from AddTask screen
  Future<void> _navigateToAddTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTask()),
    );
    if (result == true) _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181818),
      floatingActionButton: _buildFab(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildGreetingSection(),
              const SizedBox(height: 24),
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff15B86C),
                        ),
                      )
                    : _buildTaskList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
                "Good Evening, $_userName",
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xffFFFCFC),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Text(
                "One task at a time. One step closer.",
                style: TextStyle(color: Color(0xffC6C6C6), fontSize: 13),
              ),
            ],
          ),
        ),
        _buildThemeToggle(),
      ],
    );
  }

  Widget _buildGreetingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Yuhuu, Your work is",
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xffFFFCFC),
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            Text(
              "almost done! ",
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xffFFFCFC),
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            SvgPicture.asset("assets/images/hand.svg", height: 28),
          ],
        ),
      ],
    );
  }

  Widget _buildTaskList() {
    if (_tasks.isEmpty) {
      return Center(
        child: Text(
          "No tasks for today!",
          style: TextStyle(color: Colors.grey[600]),
        ),
      );
    }
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return Card(
          color: const Color(0xff242424),
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(
              task.taskName,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              task.taskDescription,
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: task.isHighPriority
                ? const Icon(Icons.priority_high, color: Colors.red)
                : null,
          ),
        );
      },
    );
  }

  Widget _buildThemeToggle() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.sunny, color: Colors.orangeAccent, size: 20),
    );
  }

  Widget _buildFab() {
    return FloatingActionButton.extended(
      onPressed: _navigateToAddTask,
      label: const Text(
        "Add Task",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      icon: const Icon(Icons.add),
      backgroundColor: const Color(0xff15B86C),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
