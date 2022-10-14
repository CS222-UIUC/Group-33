import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:semaphoreci_flutter_demo/pages/home.dart';
import 'package:semaphoreci_flutter_demo/util/playlist_creation.dart';

import '../util/mood.dart';

class Player extends StatefulWidget {
  final Logger logger;
  const Player(this.logger, {Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late final PlaylistCreation playlistCreation;
  late final Logger _logger;
  Mood dropdownValue = Mood.angry;

  @override
  void initState() {
    _logger = widget.logger;
    playlistCreation = PlaylistCreation(_logger);
    super.initState();
  }

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
            ),
            DropdownButton<Mood>(
                value: dropdownValue,
                items: Mood.values.map((Mood value) {
                  return DropdownMenuItem<Mood>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (Mood? value) {
                  playlistCreation.createSpotifyPlaylist(value!);

                  setState(() {
                    dropdownValue = value;
                  });
                }
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
