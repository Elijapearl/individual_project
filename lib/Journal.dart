import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JournalEntryPage extends StatefulWidget {
  final String selectedMood;
  const JournalEntryPage({super.key, required this.selectedMood});

  @override
  State<JournalEntryPage> createState() => _JournalEntryPageState();
}

class _JournalEntryPageState extends State<JournalEntryPage> {
  final TextEditingController controller = TextEditingController();

  String getCurrentDateTime() {
    final now = DateTime.now();
    return DateFormat('yyyy-MM-dd HH:mm').format(now);
  }

  @override
  Widget build(BuildContext context) {
    final dateTime = getCurrentDateTime();

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Mood Journal',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
            shadows: [
              Shadow(blurRadius: 10, color: Colors.black, offset: Offset(2, 2)),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date/Time: $dateTime',
                style: const TextStyle(fontSize: 16, color: Colors.pink)),
            const SizedBox(height: 20),
            const Text('Write a little more about this (optional):',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink)),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Type your journal here...',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pinkAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final mood = widget.selectedMood;
                  final desc = controller.text.trim();
                  Navigator.pop(context, {
                    'mood': mood,
                    'desc': desc.isEmpty ? 'No description' : desc,
                    'date': getCurrentDateTime(),
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent[700]),
                child:
                const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}


