import 'dart:async';
import 'dart:convert' as convert;
import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:semaphoreci_flutter_demo/model/audio_features.dart';
import 'package:semaphoreci_flutter_demo/model/followed_artists.dart';
import 'package:semaphoreci_flutter_demo/model/top_artists.dart';
import 'package:semaphoreci_flutter_demo/model/top_tracks.dart';
import 'package:semaphoreci_flutter_demo/util/mood.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class PlaylistCreation {
  late final Logger _logger;
  String authenticationToken = '';

  PlaylistCreation(Logger logger) {
    _logger = logger;
  }

  Future<void> createSpotifyPlaylist(Mood mood) async {
    final topArtistsUri = await aggregateTopArtists();
    final topTracks = await aggregateTopTracks(topArtistsUri!);
    final selectedTracks = await selectTracks(topTracks!, mood);

    setStatus(selectedTracks.toString());
  }

  Future<List<String>?> selectTracks(List<String> topTracks, Mood mood) async {

    final selectedTracks = <String>[];

    topTracks.shuffle();
    for (var i = 0; i < topTracks.length; i += 50) {
      final trackSubset = topTracks.sublist(i, min(topTracks.length, i+50));
      final track_features = await getAudioFeatures(trackSubset.join(','));
      for (final track_feature in track_features!.audio_features) {
        switch (mood) {
          case Mood.sad: {
            if (track_feature.valence < 0.2
                && track_feature.danceability < 0.3
                && track_feature.energy < 0.3) {
              selectedTracks.add(track_feature.uri);
            }
          }
          break;

          case Mood.angry: {
            if (0.08 <= track_feature.valence && track_feature.valence < 0.33
                && track_feature.danceability < 0.7
                && track_feature.energy < 0.7) {
              selectedTracks.add(track_feature.uri);
            }
          }
          break;

          case Mood.disgust: {
            if (0.2 <= track_feature.valence && track_feature.valence < 0.55
                && track_feature.danceability < 0.85
                && track_feature.energy < 0.85) {
              selectedTracks.add(track_feature.uri);
            }
          }
          break;

          case Mood.neutral: {
            if (0.43 <= track_feature.valence && track_feature.valence < 0.83
                && track_feature.danceability > 0.3
                && track_feature.energy > 0.3) {
              selectedTracks.add(track_feature.uri);
            }
          }
          break;

          case Mood.surprise: {
            if (0.68 <= track_feature.valence && track_feature.valence < 0.97
                && track_feature.danceability > 0.5
                && track_feature.energy > 0.5) {
              selectedTracks.add(track_feature.uri);
            }
          }
          break;

          case Mood.happy: {
            if (0.78 <= track_feature.valence && track_feature.valence <= 1
                && track_feature.danceability > 0.57
                && track_feature.energy > 0.6) {
              selectedTracks.add(track_feature.uri);
            }
          }
          break;
        }
      }
    }

    return selectedTracks;
  }

  Future<List<String>?> aggregateTopTracks(List<String> topArtistsUri) async {
    final topTracksUri = <String>[];
    for (final artistUri in topArtistsUri) {
      final topTracksRaw = await getTopTracks(artistUri);
      final topTracks = topTracksRaw!.tracks;
      for (final track in topTracks) {
        topTracksUri.add(track.uri);
      }
    }

    // setStatus('Found the following top tracks: $topTracksUri');

    final extractedUris = topTracksUri.map((uri) => uri.split(':').last).toList();

    return extractedUris;
  }

  Future<List<String>?> aggregateTopArtists() async {
    final topArtistsName = <String>[];
    final topArtistsUri = <String>[];

    final ranges = ['short_term', 'medium_term', 'long_term'];
    for (final r in ranges) {
      final topArtistsAllData = await getTopArtists(limit: 50, time_range: r);
      final topArtistsData = topArtistsAllData?.items ?? [];
      for (final artistData in topArtistsData) {
        if (!topArtistsName.contains(artistData.name)) {
          topArtistsName.add(artistData.name);
          topArtistsUri.add(artistData.uri);
        }
      }
    }

    final followedArtistsData = await getFollowedArtists(limit: 50);
    final followedArtistsObj = followedArtistsData?.artists.items ?? [];
    for (final artist in followedArtistsObj) {
      if (!topArtistsName.contains(artist.name)) {
        topArtistsName.add(artist.name);
        topArtistsUri.add(artist.uri);
      }
    }

    setStatus(topArtistsName.toString());

    // Extract the Spotify URI
    final extractedUri = topArtistsUri.map((uri) => uri.split(':').last).toList();

    return extractedUri;
  }

  Future<AudioFeatures?> getAudioFeatures(String trackQuery) async {
    final url = Uri.https('api.spotify.com',
      '/v1/audio-features', {'ids': trackQuery},);

    final audioFeaturesMap = await callSpotify(url);
    return AudioFeatures.fromJson(audioFeaturesMap!);
  }

  Future<TopTracks?> getTopTracks(String artistUri) async {
    final url = Uri.https('api.spotify.com',
        '/v1/artists/$artistUri/top-tracks', {'market': 'US'},);

    final topTracksMap = await callSpotify(url);
    return TopTracks.fromJson(topTracksMap!);
  }

  Future<FollowedArtists?> getFollowedArtists({required int limit}) async {
    final url = Uri.https('api.spotify.com', '/v1/me/following',
        {'limit': limit.toString(), 'type': 'artist'},);

    final followedArtistsMap = await callSpotify(url);
    return FollowedArtists.fromJson(followedArtistsMap!);
  }

  Future<TopArtists?> getTopArtists(
      {required int limit, required String time_range}) async {
    final url = Uri.https('api.spotify.com', '/v1/me/top/artists',
        {'limit': limit.toString(), 'time_range': time_range});

    final topArtistsMap = await callSpotify(url);
    return TopArtists.fromJson(topArtistsMap!);
  }

  Future<Map<String, dynamic>?> callSpotify(Uri url,
      {bool refreshToken = false}) async {
    final response = await http.get(url,
        headers: {'Authorization': await getAuthHeader(retry: refreshToken)});
    if (response.statusCode == 200) {
      final jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else if (response.statusCode == 401) {
      return callSpotify(url, refreshToken: true);
    } else if (response.statusCode == 400) {
      setStatus('Request failed with status: ${response.statusCode}.');
      final jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      setStatus(jsonResponse.toString());
    } else {
      setStatus('Request failed with status: ${response.statusCode}.');
      return null;
    }
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

  void setStatus(String code, {String? message}) {
    final text = message ?? '';
    _logger.i('$code$text');
  }
}
