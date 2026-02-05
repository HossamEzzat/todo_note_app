import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_note_app/screens/compelte_screen.dart';
import 'package:todo_note_app/screens/home_screen.dart';
import 'package:todo_note_app/screens/profile_screen.dart';
import 'package:todo_note_app/screens/todo_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    TodoScreen(),
    CompleteScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFF181818),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF15B86C),
        unselectedItemColor: const Color(0xFFC6C6C6),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 26,
        elevation: 8,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/todo.svg',
              colorFilter: const ColorFilter.mode(
                Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
              width: 26,
              height: 26,
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/todo.svg',
              colorFilter: const ColorFilter.mode(
                Color(0xFF15B86C),
                BlendMode.srcIn,
              ),
              width: 26,
              height: 26,
            ),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/complete.svg',
              colorFilter: const ColorFilter.mode(
                Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
              width: 26,
              height: 26,
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/complete.svg',
              colorFilter: const ColorFilter.mode(
                Color(0xFF15B86C),
                BlendMode.srcIn,
              ),
              width: 26,
              height: 26,
            ),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/profile.svg',
              colorFilter: const ColorFilter.mode(
                Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
              width: 26,
              height: 26,
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/profile.svg',
              colorFilter: const ColorFilter.mode(
                Color(0xFF15B86C),
                BlendMode.srcIn,
              ),
              width: 26,
              height: 26,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
