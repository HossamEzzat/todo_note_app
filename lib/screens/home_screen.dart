import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_app/providers/task_provider.dart';
import 'package:todo_note_app/screens/add_task.dart';
import 'package:todo_note_app/widgets/AchievedTasksCard.dart';
import 'package:todo_note_app/widgets/List_tasks_widget.dart';
import 'package:todo_note_app/widgets/highpriorty_tasks_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      floatingActionButton: ScaleTransition(
        scale: _fadeAnimation,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddTask()),
            );
          },
          label: Text(
            "Add Task",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          icon: const Icon(Icons.add_rounded, size: 22),
          backgroundColor: const Color(0xFF15B86C),
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Consumer<TaskProvider>(
                builder: (context, provider, _) {
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(provider.userName),
                            const SizedBox(height: 32),
                            _buildGreeting(),
                            const SizedBox(height: 24),
                            AchievedTasksCard(
                              doneTasks: provider.doneTasks,
                              totalTasks: provider.tasks.length,
                              completionPercentage:
                                  provider.completionPercentage,
                            ),
                            const SizedBox(height: 12),
                            HighpriortyTasksWidget(
                              highPriorityTasks: provider.highPriorityTasks,
                              onTaskTap: (task) {
                                // Navigate to task detail or edit
                              },
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Text(
                                  "My Tasks",
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFFFFCFC),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF282828),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "${provider.tasks.length}",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF15B86C),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: true,
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
        ),
      ),
    );
  }

  Widget _buildHeader(String userName) {
    return Row(
      children: [
        Hero(
          tag: 'profile_avatar',
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF15B86C).withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF15B86C).withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 26,
              backgroundImage: AssetImage("assets/images/car.jpg"),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Evening, $userName",
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFFCFC),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "One task at a time. One step closer.",
                style: GoogleFonts.poppins(
                  color: const Color(0xFFC6C6C6),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        TweenAnimationBuilder<double>(
          duration: const Duration(seconds: 2),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.rotate(angle: value * 0.5, child: child);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF282828),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orangeAccent.withOpacity(0.2)),
            ),
            child: const Icon(
              Icons.sunny,
              color: Colors.orangeAccent,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    final textStyle = GoogleFonts.poppins(
      color: const Color(0xFFFFFCFC),
      fontSize: 28,
      fontWeight: FontWeight.w600,
      height: 1.3,
      letterSpacing: 0.3,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Yuhuu, Your work is", style: textStyle),
        Row(
          children: [
            Text("almost done! ", style: textStyle),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1500),
              tween: Tween(begin: 0.0, end: 1.0),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 0.8 + (value * 0.2),
                  child: child,
                );
              },
              child: SvgPicture.asset("assets/images/hand.svg", height: 30),
            ),
          ],
        ),
      ],
    );
  }
}
