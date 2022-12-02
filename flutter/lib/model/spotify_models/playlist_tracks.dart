import 'package:json_annotation/json_annotation.dart';
import 'package:semaphoreci_flutter_demo/model/spotify_models/playlist_track.dart';

part 'playlist_tracks.g.dart';

@JsonSerializable()
class PlaylistTracks {
  PlaylistTracks(this.items);

  List<PlaylistTrack> items;

  factory PlaylistTracks.fromJson(Map<String, dynamic> json) =>
      _$PlaylistTracksFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistTracksToJson(this);
}
