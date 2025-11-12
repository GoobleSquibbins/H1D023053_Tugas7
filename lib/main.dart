import 'package:flutter/material.dart';
import 'package:tugas_7_pertemuan_8_pemmob_2025/pages/about_page.dart';
import 'package:tugas_7_pertemuan_8_pemmob_2025/pages/home_page.dart';
import 'package:tugas_7_pertemuan_8_pemmob_2025/pages/localStorage/add_entry.dart';
import 'package:tugas_7_pertemuan_8_pemmob_2025/pages/localStorage/delete_entry.dart';
import 'pages/login_page.dart';
import 'pages/hunters_note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'router_flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/huntersNote': (context) => const HuntersNote(),
        '/about': (context) => const AboutPage(),
        '/addEntry': (context) => const AddEntry(),
        '/deleteEntry': (context) => const DeleteEntry(),
      },
    );
  }
}
