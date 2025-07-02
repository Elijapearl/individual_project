import 'package:flutter/material.dart';
import 'Journal.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Select Mood',
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
                  return Card(
                    color: selectedMood == mood ? Colors.pink[100] : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.pinkAccent),
                    ),
                    child: ListTile(
                      title: Text(
                        mood,
                        style: TextStyle(
                          color: Colors.pink[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: Radio<String>(
                        value: mood,
                        groupValue: selectedMood,
                        onChanged: (value) {
                          setState(() {
                            selectedMood = value;
                          });
                        },
                        activeColor: Colors.pinkAccent,
                      ),
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
                    ).then((result) {
                      if (result != null) {
                        Navigator.pop(context, result); // return result to Dashboard
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent[700]),
                  child: const Text(
                    "I've chosen what I feel",
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