// ignore_for_file: unnecessary_underscores

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_note_app/models/task_model.dart';
import 'package:todo_note_app/screens/add_task.dart';
import 'package:todo_note_app/widgets/build_task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = "User";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString("name") ?? "User";
    });
  }

  Future<void> _navigateToAddTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddTask()),
    );
    if (result == true) _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddTask,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
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
              Expanded(child: BuildTaskWidget()),
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
