import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_app/providers/task_provider.dart';
import 'package:todo_note_app/screens/main_screen.dart';
import 'screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(create: (_) => TaskProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF181818),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF181818),
          elevation: 0,
          titleTextStyle: GoogleFonts.plusJakartaSans(
            color: const Color(0xffFFFCFC),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: false,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      home: Consumer<TaskProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: Color(0xFF15B86C)),
              ),
            );
          }
          return provider.userName == "User"
              ? const Welcome()
              : const MainScreen();
        },
      ),
    );
  }
}
