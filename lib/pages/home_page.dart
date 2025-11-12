import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'side_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = '';

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Guest';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  @override
  Widget build(BuildContext context) {
    final greetings = [
      "Nice to see you, hunter $_username!",
      "Good hunting, $_username!",
      "Welcome back to the hunt, $_username!",
      "Stay sharp out there, $_username!",
      "The guild’s counting on you, $_username!",
      "Sharpen your blades, $_username!",
      "Another glorious hunt awaits, $_username!",
    ];

    final random = Random();
    final randomGreeting = greetings[random.nextInt(greetings.length)];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Page",
          style: TextStyle(
            color: const Color(0xFF432818),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF7C6A0A),
      ),
      backgroundColor: const Color(0xFFFFE8D6),
      drawer: const SideMenu(),
      body: Center(
        child: Text(
          randomGreeting,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
