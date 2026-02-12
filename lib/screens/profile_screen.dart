import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_app/providers/task_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final name = context.read<TaskProvider>().userName;
      _nameController.text = name;
    });
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.22),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 58,
                        backgroundColor: Colors.grey.shade800,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey.shade900,
                          backgroundImage: const AssetImage(
                            "assets/images/car.jpg",
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A3A3A),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.35),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Column(
                  children: [
                    // Name
                    Text(
                      context.read<TaskProvider>().userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "One task at a time. One step closer.",
                      style: TextStyle(
                        color: Color(0xffC6C6C6),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // const SizedBox(height: 24),
              // TextField(
              //   controller: _nameController,
              //   style: const TextStyle(color: Colors.white, fontSize: 18),
              //   textInputAction: TextInputAction.done,
              //   onSubmitted: (_) => _updateName(),
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: const Color(0xFF282828),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12),
              //       borderSide: BorderSide.none,
              //     ),
              //     suffixIcon: IconButton(
              //       icon: const Icon(Icons.check, color: Color(0xFF15B86C)),
              //       onPressed: _updateName,
              //     ),
              //   ),
              // ),
              SizedBox(height: 24),
              Text(
                "Profile Info",
                style: TextStyle(
                  color: const Color(0xFFFCFCFC),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),

              Divider(color: const Color(0xFF6e6e6e), thickness: 1, height: 1),
              // Stts
              const Text(
                "Statistics",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Consumer<TaskProvider>(
                builder: (context, provider, _) {
                  final total = provider.tasks.length;
                  final completed = provider.completedTasks.length;
                  return Row(
                    children: [
                      _buildStatCard("Total Tasks", total.toString()),
                      const SizedBox(width: 16),
                      _buildStatCard("Completed", completed.toString()),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),

              // Reset button
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: _showResetDialog,
                  icon: const Icon(Icons.delete_forever),
                  label: const Text("Reset App Data"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _updateName() {
  //   final text = _nameController.text.trim();
  //   if (text.isEmpty) return;
  //   context.read<TaskProvider>().updateUserName(text);
  //   ScaffoldMessenger.of(
  //     context,
  //   ).showSnackBar(const SnackBar(content: Text('Name updated!')));
  // }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF282828),
        title: const Text(
          "Clear All Data",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "Are you sure? This will delete all tasks and reset your name.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Ideally expose a clearAll() in TaskProvider.
              context.read<TaskProvider>()
                ..clearAllTasks()
                ..updateUserName("User");
              Navigator.pop(context);
            },
            child: const Text("Clear", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF282828),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF15B86C),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
