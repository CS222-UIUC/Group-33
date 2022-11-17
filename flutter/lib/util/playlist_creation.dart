import 'dart:async';
import 'dart:convert' as convert;
import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:semaphoreci_flutter_demo/model/spotify_models//top_tracks.dart';
import 'package:semaphoreci_flutter_demo/model/spotify_models/audio_features.dart';
import 'package:semaphoreci_flutter_demo/model/spotify_models/create_playlist.dart';
import 'package:semaphoreci_flutter_demo/model/spotify_models/followed_artists.dart';
import 'package:semaphoreci_flutter_demo/model/spotify_models/top_artists.dart';
import 'package:semaphoreci_flutter_demo/model/spotify_models/user_profile.dart';
import 'package:semaphoreci_flutter_demo/util/mood.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class PlaylistCreation {
  late final Logger _logger;
  String authenticationToken = '';

  PlaylistCreation(Logger logger) {
    _logger = logger;
  }

  Future<String> createSpotifyPlaylist(Mood mood) async {
    final topArtistsUri = await aggregateTopArtists();
    final topTracks = await aggregateTopTracks(topArtistsUri!);
    final selectedTracks = await selectTracks(topTracks!, mood);

    return createPlaylist(selectedTracks!, mood);
  }

  Future<String> createPlaylist(List<String> trackUris, Mood mood) async {
    final userProfile = await getUserProfile();

    final newPlaylist = await postNewPlaylist(userProfile!.id, 'Mood $mood');

    trackUris.shuffle();
    await addItemsToPlaylist(newPlaylist!.id, trackUris);

    return newPlaylist.id;
  }

  Future<void> addItemsToPlaylist(
    String playlistId,
    List<String> trackUris,
  ) async {
    final url = Uri.https(
      'api.spotify.com',
      '/v1/playlists/$playlistId/tracks',
    );
    final body = convert.jsonEncode(<String, dynamic>{
      'uris': trackUris,
    });

    await callSpotifyPost(url, body);
  }

  Future<List<String>?> selectTracks(List<String> topTracks, Mood mood) async {
    final selectedTracks = <String>[];

    topTracks.shuffle();
    for (var i = 0; i < topTracks.length; i += 50) {
      final trackSubset = topTracks.sublist(i, min(topTracks.length, i + 50));
      final trackFeatures = await getAudioFeatures(trackSubset.join(','));
      for (final trackFeature in trackFeatures!.audio_features) {
        switch (mood) {
          case Mood.sad:
            {
              if (trackFeature.valence < 0.2 &&
                  trackFeature.danceability < 0.3 &&
                  trackFeature.energy < 0.3) {
                selectedTracks.add(trackFeature.uri);
              }
            }
            break;

          case Mood.angry:
            {
              if (0.08 <= trackFeature.valence &&
                  trackFeature.valence < 0.33 &&
                  trackFeature.danceability < 0.7 &&
                  trackFeature.energy < 0.7) {
                selectedTracks.add(trackFeature.uri);
              }
            }
            break;

          case Mood.disgust:
            {
              if (0.2 <= trackFeature.valence &&
                  trackFeature.valence < 0.55 &&
                  trackFeature.danceability < 0.85 &&
                  trackFeature.energy < 0.85) {
                selectedTracks.add(trackFeature.uri);
              }
            }
            break;

          case Mood.neutral:
            {
              if (0.43 <= trackFeature.valence &&
                  trackFeature.valence < 0.83 &&
                  trackFeature.danceability > 0.3 &&
                  trackFeature.energy > 0.3) {
                selectedTracks.add(trackFeature.uri);
              }
            }
            break;

          case Mood.surprise:
            {
              if (0.68 <= trackFeature.valence &&
                  trackFeature.valence < 0.97 &&
                  trackFeature.danceability > 0.5 &&
                  trackFeature.energy > 0.5) {
                selectedTracks.add(trackFeature.uri);
              }
            }
            break;

          case Mood.happy:
            {
              if (0.78 <= trackFeature.valence &&
                  trackFeature.valence <= 1 &&
                  trackFeature.danceability > 0.57 &&
                  trackFeature.energy > 0.6) {
                selectedTracks.add(trackFeature.uri);
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

    return extractUris(topTracksUri);
  }

  Future<List<String>?> aggregateTopArtists() async {
    final topArtistsName = <String>[];
    final topArtistsUri = <String>[];

    final ranges = ['short_term', 'medium_term', 'long_term'];
    for (final r in ranges) {
      final topArtistsAllData = await getTopArtists(limit: 50, timeRange: r);
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

    logMessage(topArtistsName.toString());

    // Extract the Spotify URIs
    return extractUris(topArtistsUri);
  }

  Future<CreatePlaylist?> postNewPlaylist(String userId, String name) async {
    final url = Uri.https('api.spotify.com', '/v1/users/$userId/playlists');
    final body = convert.jsonEncode(<String, String>{
      'name': name,
    });

    final playlistMap = await callSpotifyPost(url, body);
    return CreatePlaylist.fromJson(playlistMap!);
  }

  Future<UserProfile?> getUserProfile() async {
    final url = Uri.https('api.spotify.com', 'v1/me');

    final userProfileMap = await callSpotify(url);
    return UserProfile.fromJson(userProfileMap!);
  }

  Future<AudioFeatures?> getAudioFeatures(String trackQuery) async {
    final url = Uri.https(
      'api.spotify.com',
      '/v1/audio-features',
      {'ids': trackQuery},
    );

    final audioFeaturesMap = await callSpotify(url);
    logMessage(audioFeaturesMap.toString());
    return AudioFeatures.fromJson(audioFeaturesMap!);
  }

  Future<TopTracks?> getTopTracks(String artistUri) async {
    final url = Uri.https(
      'api.spotify.com',
      '/v1/artists/$artistUri/top-tracks',
      {'market': 'US'},
    );

    final topTracksMap = await callSpotify(url);
    return TopTracks.fromJson(topTracksMap!);
  }

  Future<FollowedArtists?> getFollowedArtists({required int limit}) async {
    final url = Uri.https(
      'api.spotify.com',
      '/v1/me/following',
      {'limit': limit.toString(), 'type': 'artist'},
    );

    final followedArtistsMap = await callSpotify(url);
    return FollowedArtists.fromJson(followedArtistsMap!);
  }

  Future<TopArtists?> getTopArtists({
    required int limit,
    required String timeRange,
  }) async {
    final url = Uri.https(
      'api.spotify.com',
      '/v1/me/top/artists',
      {'limit': limit.toString(), 'time_range': timeRange},
    );

    final topArtistsMap = await callSpotify(url);
    return TopArtists.fromJson(topArtistsMap!);
  }

  Future<Map<String, dynamic>?> callSpotifyPost(
    Uri url,
    String body, {
    bool refreshToken = false,
  }) async {
    final response = await http.post(
      url,
      headers: {'Authorization': await getAuthHeader(retry: refreshToken)},
      body: body,
    );

    // Handle response
    if (response.statusCode == 201) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 401) {
      return callSpotifyPost(url, body, refreshToken: true);
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
