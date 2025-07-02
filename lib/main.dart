
import 'package:flutter/material.dart';
import 'FrontPage.dart';


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