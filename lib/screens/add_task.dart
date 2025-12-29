import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_screen.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

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
    super.dispose();
    taskController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181818),

      appBar: AppBar(
        backgroundColor: const Color(0xff181818),
        elevation: 0,
        title: Text(
          "New Task",
          style: GoogleFonts.plusJakartaSans(
            color: Color(0xffFFFCFC),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Task Name",
                      style: GoogleFonts.poppins(
                        color: Color(0xffFFFCFC),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
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
                          color: Color(0xff6D6D6D),
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color(0xff282828),
                        filled: true,
                      ),
                      style: GoogleFonts.poppins(
                        color: Color(0xffFFFCFC),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      cursorColor: Color(0xffFFFCFC),
                      cursorHeight: 24,
                      cursorWidth: 2,
                      cursorRadius: Radius.circular(8),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Task Description",
                      style: GoogleFonts.poppins(
                        color: Color(0xffFFFCFC),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: taskController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter task description";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter task description",
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xff6D6D6D),
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color(0xff282828),
                        filled: true,
                      ),
                      style: GoogleFonts.poppins(
                        color: Color(0xffFFFCFC),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 5,
                      cursorColor: Color(0xffFFFCFC),
                      cursorHeight: 24,
                      cursorWidth: 2,
                      cursorRadius: Radius.circular(8),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "High Priority  ",
                          style: GoogleFonts.poppins(
                            color: Color(0xffFFFCFC),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Switch(
                          value: isHighPriority,
                          activeThumbColor: Colors.white,
                          activeTrackColor: Color(0xff15b86c),
                          inactiveTrackColor: Color(0xff6D6D6D),
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
              Spacer(),
              ElevatedButton.icon(
                icon: Icon(Icons.add),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff15b86c),
                  foregroundColor: Color(0xffFFFCFC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                label: Text("add task"),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
