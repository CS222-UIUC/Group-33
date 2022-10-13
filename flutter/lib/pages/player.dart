import 'package:flutter/material.dart';
import 'package:semaphoreci_flutter_demo/pages/home.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: const ValueKey('Player Key'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MoodSpot'),
        ),
        body: Column(
          children: [
            const Text('Logged In!'),
            TextButton(
              onPressed: logoutButton,
              child: const Text('Log out'),
              key: const ValueKey('button.logout'),
            )
          ],
        ),
      ),
    );
  }

  void logoutButton() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const Home(),
      ),
    );
  }
}
