import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddMood.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map<String, String>> savedMoods = [];
  String userName = '';

  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    loadName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        // Flutter automatically shows the back arrow
        automaticallyImplyLeading: true,
        title: const Text(
          'MoodBoard Tracker',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black,
                offset: Offset(2, 2),
              )
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
            Center(
              child: Text(
                'Hi $userName! Welcome to your MoodBoard Dashboard.',
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.pink,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Your Moods',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: savedMoods.isEmpty
                  ? const Center(
                child: Text(
                  'No moods added yet.',
                  style: TextStyle(color: Colors.pink),
                ),
              )
                  : ListView.builder(
                itemCount: savedMoods.length,
                itemBuilder: (context, index) {
                  final mood = savedMoods[index];
                  return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.pinkAccent),
                  borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                  title: Text(
                  mood['mood']!,
                  style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                  ),
                  ),
                  subtitle: Text(
                  mood['desc']!,
                  style: const TextStyle(color: Colors.black87),
                  ),
                  trailing: Text(
                  mood['date']!,
                  style: const TextStyle(color: Colors.pinkAccent),
                  ),
                  ),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MoodSelectionPage(),
                    ),
                  );
                  if (result != null && result is Map<String, String>) {
                    setState(() {
                      savedMoods.add(result);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent[700],
                ),
                child: const Text(
                  'Add Mood',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}