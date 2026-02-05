import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_note_app/screens/main_screen.dart';

import 'screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String? name = prefs.getString("name");
  runApp(MyApp(name: name));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.name});
  final String? name;

  // This widget is the root of your application.
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
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: false,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      home: name == null ? Welcome() : MainScreen(),
    );
  }
}
