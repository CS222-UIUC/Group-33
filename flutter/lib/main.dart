// ignore_for_file: public_member_api_docs

import 'package:semaphoreci_flutter_demo/util/popup_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:semaphoreci_flutter_demo/pages/home.dart';

// coverage:ignore-start
void main() async {
  await dotenv.load();
  runApp(MyApp());
}
// coverage:ignore-end

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: popupKey,
      key: const ValueKey('Main App'),
      title: 'Moodspot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Colors.blueAccent),
      ),
      home: const Home(),
    );
  }
}
