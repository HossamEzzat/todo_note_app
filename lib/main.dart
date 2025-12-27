import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_note_app/screens/home_screen.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      home: name == null ? Welcome() : HomeScreen(),
    );
  }
}
