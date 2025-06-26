import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MoodBoardApp());
}

class MoodBoardApp extends StatelessWidget {
  const MoodBoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FrontPage(),
    );
  }
}


class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'MoodBoard Tracker',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Hello! What is your name?',
                style: TextStyle(fontSize: 20, color: Colors.pink),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent[700],
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () {
                  String name = nameController.text.trim();
                  if (name.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(userName: name),
                      ),
                    );
                  }
                },
                child: const Text('Get Started', style: TextStyle(fontSize: 20, color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  final String userName;
  const DashboardPage({super.key, required this.userName});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map<String, String>> savedMoods = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text(
          'MoodBoard Tracker',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
            shadows: [Shadow(blurRadius: 10, color: Colors.black, offset: Offset(2, 2))],
          ),
        ),
        backgroundColor: Colors.pinkAccent[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Hi ${widget.userName}! Welcome to your MoodBoard Dashboard.',
                style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.pink),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Moods',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: savedMoods.isEmpty
                  ? const Center(child: Text('No moods added yet.', style: TextStyle(color: Colors.pink)))
                  : ListView.builder(
                itemCount: savedMoods.length,
                itemBuilder: (context, index) {
                  final mood = savedMoods[index];
                  return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                      title: Text(mood['mood']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(mood['desc']!),
                  trailing: Text(mood['date']!),
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
                    MaterialPageRoute(builder: (context) => const MoodSelectionPage()),
                  );
                  if (result != null && result is Map<String, String>) {
                    setState(() {
                      savedMoods.add(result);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent[700]),
                child: const Text('Add Mood', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MoodSelectionPage extends StatefulWidget {
  const MoodSelectionPage({super.key});

  @override
  State<MoodSelectionPage> createState() => _MoodSelectionPageState();
}

class _MoodSelectionPageState extends State<MoodSelectionPage> {
  final List<String> moods = [
    'Happy', 'Sad', 'Angry', 'Tired', 'Confused', 'Annoyed', 'Awkward',
    'Sleepy', 'Sick', 'Nervous', 'Scared', 'Surprised', 'Stressed', 'Hurt', 'Disappointed'
  ];
  String? selectedMood;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(title: const Text('Select Mood'), backgroundColor: Colors.pinkAccent[700]),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hey, how are you feeling today?',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.pink),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: moods.length,
                itemBuilder: (context, index) {
                  final mood = moods[index];
                  return ListTile(
                    title: Text(mood),
                    leading: Radio<String>(
                      value: mood,
                      groupValue: selectedMood,
                      onChanged: (value) {
                        setState(() {
                          selectedMood = value;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            if (selectedMood != null)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JournalEntryPage(selectedMood: selectedMood!),
                      ),
                    ).then((result) => Navigator.pop(context, result));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent[700]),
                  child: const Text("I've chosen what I feel", style: TextStyle(color: Colors.white)),
                ),
              )
          ],
        ),
      ),
    );
  }
}

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
      appBar: AppBar(title: const Text('Mood Journal'), backgroundColor: Colors.pinkAccent[700]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date/Time: $dateTime',
                style: const TextStyle(fontSize: 16, color: Colors.pink)),
            const SizedBox(height: 20),
            const Text('Write a little more about this (optional):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink)),
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent[700]),
                child: const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
