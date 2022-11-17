// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// import 'camera_feature.dart';
import 'TakePictureScreen.dart';

// coverage:ignore-start
void main() {
  runApp(MyApp());
}
// coverage:ignore-end

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
          body: SafeArea(
            // const Text('Hello, Moodspot!'),
            child: ElevatedButton(
              child:
                const Text('Hello, Moodspot!'),
              onPressed: () {
                TakePictureScreen();
              },
            ),
          ),
        ),
      ),
    );
  }
}
