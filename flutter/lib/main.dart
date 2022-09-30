// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: const ValueKey('Main App'),
      title: 'Moodspot',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('MoodSpot'),
          ),
          body: const Text('Hello, Moodspot!'),
        ),
      ),
    );
  }
}
