import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({super.key});

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  final TextEditingController _monsterNameController = TextEditingController();
  final TextEditingController _monsterHabitatController =
      TextEditingController();
  final TextEditingController _monsterWeaknessController =
      TextEditingController();
  final TextEditingController _monsterDescController = TextEditingController();

  Future<void> _saveEntry() async {
    final prefs = await SharedPreferences.getInstance();

    String name = _monsterNameController.text;
    String habitat = _monsterHabitatController.text;
    String weakness = _monsterWeaknessController.text;
    String desc = _monsterDescController.text;

    List<String> monsterEntries = prefs.getStringList('monsterEntries') ?? [];

    int lastId = prefs.getInt('lastMonsterId') ?? 100;

    int newId = lastId + 1;

    String newEntry = jsonEncode({
      'id': newId.toString(),
      'name': name,
      'habitat': habitat,
      'weakness': weakness,
      'description': desc,
    });

    monsterEntries.add(newEntry);
    await prefs.setStringList('monsterEntries', monsterEntries);

    await prefs.setInt('lastMonsterId', newId);
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFFFFE8D6),
        title: const Text(
          "Entry Info",
          style: TextStyle(color: Color(0xFF432818)),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Color(0xFF432818)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Color(0xFF7C6A0A))),
          ),
        ],
      ),
    );
  }

  void _saveAndReturn() async {
    if (_monsterNameController.text.isEmpty ||
        _monsterHabitatController.text.isEmpty ||
        _monsterWeaknessController.text.isEmpty ||
        _monsterDescController.text.isEmpty) {
      _showDialog("Please fill all fields before saving!");
      return;
    }

    await _saveEntry();

    _showDialog("Monster entry saved!");

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/huntersNote');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Entry",
          style: TextStyle(
            color: const Color(0xFF432818),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF7C6A0A),
      ),
      backgroundColor: const Color(0xFFFFE8D6),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _monsterNameController,
                decoration: const InputDecoration(
                  labelText: "Monster's Name",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _monsterHabitatController,
                decoration: const InputDecoration(
                  labelText: "Habitat",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _monsterWeaknessController,
                decoration: const InputDecoration(
                  labelText: "Weakness",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _monsterDescController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C6A0A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: _saveAndReturn,
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Save Entry",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
