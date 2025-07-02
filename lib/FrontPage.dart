import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dashboard.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  final TextEditingController nameController = TextEditingController();
  bool showError = false;

  Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bg.jpg', fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.pink[50]?.withOpacity(0.3)),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Text(
                  'MoodBoard Tracker',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                    shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Hello! What is your name?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
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
                      borderSide: BorderSide(
                        color: showError ? Colors.red : Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: showError ? Colors.red : Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: showError ? Colors.red : Colors.pink,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                if (showError)
            const Padding(
          padding: EdgeInsets.only(top: 8),
            child: Text(
              'Please enter your name',
              style: TextStyle(color: Colors.red),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent[700],
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            onPressed: () async {
              String name = nameController.text.trim();
              if (name.isNotEmpty) {
                await saveName(name);
                setState(() {
                  showError = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardPage()),
                );
              } else {
                setState(() {
                  showError = true;
                });
              }
            },
            child: const Text('Get Started', style: TextStyle(fontSize: 20, color: Colors.white)),
          )
        ],
      ),
    ),
    ),
    ],
    ),
    );
  }
}