import 'package:flutter/material.dart';

class DeleteEntry extends StatefulWidget {
  const DeleteEntry({super.key});

  @override
  State<DeleteEntry> createState() => _DeleteEntryState();
}

class _DeleteEntryState extends State<DeleteEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Monster")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(child: Column()),
      ),
    );
  }
}
