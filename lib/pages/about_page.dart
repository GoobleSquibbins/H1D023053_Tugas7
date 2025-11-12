import 'package:flutter/material.dart';
import 'side_menu.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Hunter's Note",
          style: TextStyle(
            color: const Color(0xFF432818),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF7C6A0A),
      ),
      drawer: const SideMenu(),
      backgroundColor: const Color(0xFFFFE8D6),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: Text(
            "Hunter’s Note is a personal field journal for hunters venturing across the New World. \n Record every encounter — from the graceful Great Izuchi to the mighty Arzuros. Keep track of their weaknesses, habitats, and your own hunt experiences. \n  Designed to serve as a modern-day guild log, this app helps you store monster information, write down your hunting notes, and track your growth as a hunter. \n Whether you’re out in the Shrine Ruins or just studying monster behavior, your Hunter’s Note is always at your side.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
