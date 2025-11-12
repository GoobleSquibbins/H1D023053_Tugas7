import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'side_menu.dart';

class HuntersNote extends StatefulWidget {
  const HuntersNote({super.key});

  @override
  State<HuntersNote> createState() => _HuntersNoteState();
}

class _HuntersNoteState extends State<HuntersNote> {
  String _username = '';
  List<Map<String, String>> _monsterEntries = [];

  final List<Map<String, String>> _defaultMonsters = [
    {
      'name': 'Great Izuchi',
      'habitat': 'Shrine Ruins',
      'weakness': 'Thunder',
      'description':
          'A nimble pack leader that coordinates attacks with its smaller kin. Moves swiftly and gracefully.',
    },
    {
      'name': 'Arzuros',
      'habitat': 'Flooded Forest',
      'weakness': 'Fire',
      'description':
          'A bear-like beast that loves honey. Uses its strong forearms to crush anything that threatens its food.',
    },
    {
      'name': 'Baggi',
      'habitat': 'Frost Islands',
      'weakness': 'Fire',
      'description':
          'A cunning raptor that attacks in packs. Its icy saliva can put hunters to sleep if they are not careful.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadMonsterEntries();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Hunter';
    });
  }

  Future<void> _loadMonsterEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('monsterEntries');

    if (savedList != null) {
      final loadedMonsters = savedList
          .map((entry) => Map<String, String>.from(jsonDecode(entry)))
          .toList();

      setState(() {
        _monsterEntries = [..._defaultMonsters, ...loadedMonsters];
      });
    } else {
      setState(() {
        _monsterEntries = _defaultMonsters;
      });
    }
  }

  Future<void> _deleteMonster(dynamic id) async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('monsterEntries') ?? [];

    savedList.removeWhere((entry) {
      final data = jsonDecode(entry);
      return data['id'] == id;
    });

    await prefs.setStringList('monsterEntries', savedList);
    _loadMonsterEntries();
  }

  Future<bool> _confirmDeleteDialog(
    BuildContext context,
    String monsterName,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFFFFE8D6),
            title: const Text(
              "Delete Entry",
              style: TextStyle(color: Color(0xFF432818)),
            ),
            content: Text(
              "Are you sure you want to delete $monsterName?",
              style: const TextStyle(color: Color(0xFF432818)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Color(0xFF7C6A0A)),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ) ??
        false;
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
          "Hunter's Note",
          style: TextStyle(
            color: Color(0xFF432818),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF7C6A0A),
      ),
      backgroundColor: const Color(0xFFFFDAC6),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  randomGreeting,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF432818),
                  ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/addEntry');
                  },
                  icon: const Icon(Icons.add, color: Color(0xFFFFFFFF)),
                  label: const Text(
                    "Add Entry",
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEB6424),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _monsterEntries.length,
                itemBuilder: (context, index) {
                  final monster = _monsterEntries[index];
                  return Card(
                    color: const Color(0xFFBABD8D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                monster['name'] ?? 'Unknown Monster',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text("Habitat: ${monster['habitat'] ?? '-'}"),
                          Text("Weakness: ${monster['weakness'] ?? '-'}"),
                          const SizedBox(height: 6),
                          Text(
                            monster['description'] ?? 'No description.',
                            style: const TextStyle(color: Colors.black54),
                          ),
                          if (index >= _defaultMonsters.length)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () async {
                                    final confirm = await _confirmDeleteDialog(
                                      context,
                                      monster['name'] ?? 'this monster',
                                    );
                                    if (confirm) {
                                      _deleteMonster(monster['id']);
                                    }
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
