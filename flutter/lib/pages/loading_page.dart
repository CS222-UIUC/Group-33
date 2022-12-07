import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:semaphoreci_flutter_demo/pages/playlist_page.dart';
import 'package:semaphoreci_flutter_demo/util/mood.dart';

import 'package:semaphoreci_flutter_demo/util/playlist_creation.dart';
import 'package:semaphoreci_flutter_demo/util/playlist_track_info.dart';

class LoadingPage extends StatefulWidget {
  final Logger logger;
  final Mood mood;
  const LoadingPage(this.logger, this.mood, {Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late final PlaylistCreation playlistCreation;
  late final PlaylistTrackInfo playlistTrackInfo;
  late final Logger _logger;
  late final String playlistId;
  bool finished = false;

  @override
  void initState() {
    _logger = widget.logger;
    playlistCreation = PlaylistCreation(_logger);
    playlistTrackInfo = PlaylistTrackInfo(_logger);
    setupPlaylist();
    super.initState();
  }

  Future<void> setupPlaylist() async {
    await playlistCreation
        .createSpotifyPlaylist(widget.mood)
        .then((String value) {
      playlistId = value;
    });

    final myPlaylistInfo = await playlistTrackInfo.getTracks(playlistId);

    _logger.log(Level.info, playlistId);
    setState(() {
      finished = true;

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                PlaylistPage(widget.logger, myPlaylistInfo),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Text('Loading Page'),
          if (!finished) const Text('Not finished') else const Text('Finished'),
        ],
      ),
    );
  }
}
