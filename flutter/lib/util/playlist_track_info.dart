import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:logger/logger.dart';
import 'package:semaphoreci_flutter_demo/model/data_models/my_playlist_info.dart';
import 'package:semaphoreci_flutter_demo/model/data_models/my_track.dart';
import 'package:semaphoreci_flutter_demo/model/spotify_models/playlist_info.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class PlaylistTrackInfo {
  late final Logger _logger;
  String authenticationToken = '';

  PlaylistTrackInfo(Logger logger) {
    _logger = logger;
  }

  Future<MyPlaylistInfo> getTracks(String playlistId) async {
    final playlistInfo = await getPlaylistInfo(playlistId);

    _logger.log(Level.info, 'Playlist name: ${playlistInfo!.name}');

    if (playlistInfo.tracks.items.isNotEmpty) {
      _logger.log(Level.info, playlistInfo.tracks.items.first.track.name);
    }

    final myTracks = <MyTrack>[];
    for (var j = 0; j < playlistInfo.tracks.items.length; j++) {
      final currTrack = playlistInfo.tracks.items[j].track;

      final artistNames = StringBuffer();
      for (var i = 0; i < currTrack.artists.length; i++) {
        if (i == 0) {
          artistNames.write(currTrack.artists[i].name);
        } else {
          artistNames.write(', ');
          artistNames.write(currTrack.artists[i].name);
        }
      }

      final currDate = DateTime.now()
          .toString()
          .split('.')
          .first
          .replaceAll(RegExp(':'), '-');
      _logger.log(Level.info, 'custom/$currDate-$j.jpg');

      File? imageFile;
      if (currTrack.album.images.isNotEmpty) {
        final imageId = await ImageDownloader.downloadImage(
          currTrack.album.images.last.url,
          destination: AndroidDestinationType.directoryDownloads
            ..subDirectory('custom/$currDate-$j.jpg'),
        );
        final path = await ImageDownloader.findPath(imageId!);
        imageFile = File(path!);
        _logger.log(Level.info, 'imageId: $imageId, path: $path');
      }

      final minutes = (currTrack.duration_ms / 60000).floor();
      final seconds =
          ((currTrack.duration_ms - (minutes * 60000)) / 1000).floor();
      var secondsStr = seconds.toString();
      if (seconds < 10) {
        secondsStr = '0$secondsStr';
      }
      final duration = '$minutes:$secondsStr';

      myTracks.add(
        MyTrack(
          currTrack.name,
          artistNames.toString(),
          duration,
          currTrack.uri,
          imageFile,
        ),
      );
    }

    final currDate =
        DateTime.now().toString().split('.').first.replaceAll(RegExp(':'), '-');
    File? playlistImage;
    if (playlistInfo.images.isNotEmpty) {
      final imageId = await ImageDownloader.downloadImage(
        playlistInfo.images.first.url,
        destination: AndroidDestinationType.directoryDownloads
          ..subDirectory('custom/$currDate-pImage.jpg'),
      );
      final path = await ImageDownloader.findPath(imageId!);
      playlistImage = File(path!);
    }

    return MyPlaylistInfo(
      playlistInfo.name,
      playlistInfo.id,
      myTracks,
      playlistImage,
    );
  }

  Future<PlaylistInfo?> getPlaylistInfo(String playlistId) async {
    final url = Uri.https('api.spotify.com', 'v1/playlists/$playlistId');

    final playlistInfo = await callSpotify(url);
    return PlaylistInfo.fromJson(playlistInfo!);
  }

  Future<Map<String, dynamic>?> callSpotify(
    Uri url, {
    bool refreshToken = false,
  }) async {
    final response = await http.get(
      url,
      headers: {'Authorization': await getAuthHeader(retry: refreshToken)},
    );

    // Handle response
    if (response.statusCode == 200 || response.statusCode == 201) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 401) {
      return callSpotify(url, refreshToken: true);
    } else if (response.statusCode == 400) {
      logMessage('Request failed with status: ${response.statusCode}.');
      final jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      logMessage(jsonResponse.toString());
    } else {
      logMessage('Request failed with status: ${response.statusCode}.');
    }
    return null;
  }

  Future<String> getAuthHeader({bool retry = false}) async {
    if (authenticationToken.isEmpty || retry) {
      authenticationToken = await SpotifySdk.getAccessToken(
        clientId: dotenv.env['CLIENT_ID'].toString(),
        redirectUrl: dotenv.env['REDIRECT_URL'].toString(),
        scope: 'app-remote-control, '
            'user-modify-playback-state, '
            'playlist-read-private, user-follow-read, '
            'playlist-modify-public,user-read-currently-playing,'
            'user-library-read, user-top-read, playlist-modify-public',
      );
    }
    return 'Bearer $authenticationToken';
  }

  List<String> extractUris(List<String> spotifyUris) {
    return spotifyUris.map((uri) => uri.split(':').last).toList();
  }

  void logMessage(String code, {String? message}) {
    final text = message ?? '';
    _logger.i('$code$text');
  }
}
