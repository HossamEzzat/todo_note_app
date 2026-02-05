// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_app/models/task_model.dart';
import 'package:todo_note_app/providers/task_provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController taskController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isHighPriority = false;

  @override
  void dispose() {
    taskController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Task Name",
                        style: GoogleFonts.poppins(
                          color: const Color(0xffFFFCFC),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: taskController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter task name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter task name",
                          hintStyle: GoogleFonts.poppins(
                            color: const Color(0xff6D6D6D),
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: const Color(0xff282828),
                          filled: true,
                        ),
                        style: GoogleFonts.poppins(
                          color: const Color(0xffFFFCFC),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        cursorColor: const Color(0xffFFFCFC),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Task Description",
                        style: GoogleFonts.poppins(
                          color: const Color(0xffFFFCFC),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintText: "Enter task description",
                          hintStyle: GoogleFonts.poppins(
                            color: const Color(0xff6D6D6D),
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: const Color(0xff282828),
                          filled: true,
                        ),
                        style: GoogleFonts.poppins(
                          color: const Color(0xffFFFCFC),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 5,
                        cursorColor: const Color(0xffFFFCFC),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "High Priority",
                            style: GoogleFonts.poppins(
                              color: const Color(0xffFFFCFC),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Switch(
                            value: isHighPriority,
                            activeThumbColor: Colors.white,
                            activeTrackColor: const Color(0xff15b86c),
                            inactiveTrackColor: const Color(0xff6D6D6D),
                            inactiveThumbColor: Colors.grey,
                            onChanged: (value) {
                              setState(() {
                                isHighPriority = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final task = TaskModel(
                      taskName: taskController.text,
                      taskDescription: descriptionController.text,
                      isHighPriority: isHighPriority,
                    );

                    context.read<TaskProvider>().addTask(task);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff15b86c),
                  foregroundColor: const Color(0xffFFFCFC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  fixedSize: Size(MediaQuery.of(context).size.width, 48),
                ),
                label: const Text("Add Task"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
